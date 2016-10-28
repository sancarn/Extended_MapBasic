EMB_Core_BlockComment(mbsource){
  pair := []
  Matches := []
  i := 1
  
  ;pattern ignores everything inside quotes (all defined strings)
  pattern = "(?:.|\s)*?"|(\/\*(?:.|\s)*?\*\/)
  
  ;Match in the mbsource where matches pattern
  i := regexmatch(mbsource, "iO)" . pattern, oMatch, i)
  
  ;Loop over all i
  while i <> 0 {
    If oMatch.Value(1) {
	  ;msgbox, % oMatch.Value(0) "-->" oMatch.Value(1) "-->" oMatch.Count
	  
      ;Add those that match 2nd criteria (real comments) to match object
      pair := [oMatch.Pos(0), oMatch.Len(0)]
      
      ;Add pair array to collection of pairs - "Matches" represents all the matches that are not part of existing strings.
      Matches.push(pair)
    }
    
    ;Next i
    i := oMatch.Pos(0) + oMatch.Len(0)
	
    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }
  
  if (!EMB_Compact_Transpile) {
    ;Loop over Matches
	loop, % Matches.Length()
    {
	  LoopVar := Matches.Length() - A_Index + 1
      subSrc := p_EMB_Core_BC_removeFromString(mbsource,Matches[LoopVar][1],Matches[LoopVar][2])
		subSrc := RegExReplace(subSrc,"\/\*\s*","'")
		subSrc := StrReplace(subSrc,"`r`n","`r`n'")
		subSrc := RegExReplace(subSrc,"\s*\*\/","`r`n")
      p_EMB_Core_BC_insertIntoString(mbsource,subSrc,matches[LoopVar][1])
    }
  } else {
    LoopVar := Matches.Length() - A_Index + 1
    p_EMB_Core_BC_removeFromString(mbsource,Matches[LoopVar][1],Matches[LoopVar][2])
  }
  
  
return mbsource
}

p_EMB_Core_BC_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  out_String := SubStr(src, index, length)
  src := SubStr(src,1,index - 1) . SubStr(src,index + length + 1)
  return out_String
}

p_EMB_Core_BC_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}
