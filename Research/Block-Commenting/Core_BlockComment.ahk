EMB_Core_BlockComment(mbsource){
  pair := []
  Matches := []
  pattern = "(?:.|\s)*?\/\*(?:.|\s)*?\*\/(?:.|\s)*?"|(\/\*(?:.|\s)*?\*\/)
  i := 1
  
  ;Match in the mbsource where matches pattern
  i := regexmatch(mbsource, "io)" pattern, oMatch, i)
  
  ;Loop over all i
  while i <> 0 {    
    If (Match.Count > 1) {
      ;Add those that match 2nd criteria (real comments) to match object
      pair := [oMatch.Pos(1), oMatch.Len(1)]
      
      ;Add pair array to collection of pairs - "Matches" represents all the matches that are not part of existing strings.
      Matches.push pair
    }
    
    ;Next i
    i := Match.Pos(0) + Match.Len(0)
    
    ;Get next match from mbsource
    i := regexmatch(mbsource, "io)" pattern, oMatch, i)
  }
  
  ;if !EMB_Compact_Transpile then
  ;  for each match in matches
  ;    extract and remove match from code
  ;    replace /* with '
  ;    replace `r`n with `r`n'
  ;    replace */ with `r`n
  ;    re-insert new code where match was
  ;  next match
  ;Else
  ;  for each match in matches
  ;    remove match from code
  ;  next match
  ;End If
  
  if (!EMB_Compact_Transpile) {
    loop, matches.length()
    {
      subSrc := p_EMB_Core_BC_removeFromString(mbsource,matches[A_Index][0],matches[A_Index][1])
        StringReplace, subSrc, subSrc, /*, '
        StringReplace, subSrc, subSrc, `r`n, `r`n'
        StringReplace, subSrc, subSrc, */, `r`n
      p_EMB_Core_BC_insertIntoString(mbsource,subSrc,matches[A_Index][0])
    }
  } else {
    p_EMB_Core_BC_removeFromString(mbsource,matches[A_Index][0],matches[A_Index][1])
  }
  
  
return mbsource
}

p_EMB_Core_BC_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  StringMid, out_String, %src%, %index%, %length%
  src := SubStr(src,1,index - 1) . SubStr(src,index + length + 1)
  return out_String
}

p_EMB_Core_BC_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}
