EMB_Lib_BlockStrings(mbsource){
  
  i := 1
  
  ;pattern ignores everything inside quotes (all defined strings)
  pattern = "(?:.|\s)*?"|\B(\(\"(?:.|\s)*?\"\))
  
  ;Match in the mbsource where matches pattern
  i := regexmatch(mbsource, "iO)" . pattern, oMatch, i)
  
  ;WithContents <RegEx> , <transpilerFunctionName>
  ;WithContents  "(?:.|\s)*?"|\B(\(\"(?:.|\s)*?\"\)) , p_EMB_Lib_BlockStrings_TranspileSubSrc
  
  ;Loop over all i
  while i <> 0 {
    b := oMatch.Value(0)
	c := oMatch.Value(1)
	If oMatch.Value(1) {
		;replace captured block string with concatenated lines and mbCrLf comments
		subSrc := p_EMB_Lib_BlockStrings_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))
			subSrc := RegExReplace(subSrc,"\(\""\s*","""")
			subSrc := StrReplace(subSrc,"`r`n",""" & embCrLf &`r`n""")
			subSrc := RegExReplace(subSrc,"\s*\""\)","""")
		p_EMB_Lib_BlockStrings_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
    }
	
    ;Next i (Needed in the case where oMatch.Value(1) = "")
    i := oMatch.Pos(0) + 1 ;oMatch.Len(0)
	
    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }
  
return mbsource
}

;May want to merge this in a core library as this is a direct duplicate from another 
p_EMB_Lib_BlockStrings_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  out_String := SubStr(src, index, length)
  src := SubStr(src,1,index - 1) . SubStr(src,index + length)
  return out_String
}

p_EMB_Lib_BlockStrings_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}
