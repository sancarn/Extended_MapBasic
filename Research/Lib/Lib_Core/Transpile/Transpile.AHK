




ForEachPattern(mbsource,pattern,operationName){
  ;Match in the mbsource where matches pattern
  i := regexmatch(mbsource, "iO)" . pattern, oMatch, i)

  ;Loop over all i
  while i <> 0 {
    %operationName%(mbsource,oMatch,oParams)

    ;Next i (Needed in the case where oMatch.Value(1) = "")
    i := oMatch.Pos(0) + oMatch.Len(0)  ;+1??? ;TODO

    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }

  return mbsource
}

Transpiler_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  out_String := SubStr(src, index, length)
  src := SubStr(src,1,index - 1) . SubStr(src,index + length)
  return out_String
}

Transpiler_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}
