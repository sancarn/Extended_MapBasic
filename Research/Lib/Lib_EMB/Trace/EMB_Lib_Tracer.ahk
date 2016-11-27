EMB_Lib_Tracer(mbcode){
  ;Pattern explanation:
  ;".*?sub\s+.+?\(.*?"|".*?function\s+.+?\(.*?"   ignores [Print "sub ... "] or [Print "Function ..."]
  ;End\s+Sub|End\s+Function                       ignores [End Sub] or [End Function]
  ;Declare\s+Sub|Declare\s+Function               ignores [Declare Sub] or [Declare Function]

  ;(sub\s+.+?\((?:.|\s)*?\))|(function\s+.+?\((?:.|\s)*?\)\s+as\s+\w+)    captures [Sub .+(.*)] and [Function .+(.*) as .+]

  ;*************************************************************************************************************************
  pattern = ".*?sub\s+.+?\(.*?"|".*?function\s+.+?\(.*?"|End\s+Sub|End\s+Function|Declare\s+Sub|Declare\s+Function|(sub\s+.+?\((?:.|\s)*?\))|(function\s+.+?\((?:.|\s)*?\)\s+as\s+\w+)
  ;*************************************************************************************************************************

  ;Match in the mbsource where matches pattern
  i := regexmatch(mbsource, "iO)" . pattern, oMatch, i)

  ;Loop over all i
  while i <> 0 {
    If oMatch.Value(1) {
      ;replace captured block comment with single line comments
      subSrc := p_EMB_Lib_BlockComment_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))
        subSrc := p_EMB_Lib_Tracer_sHandleSubSrc(subSrc)
      p_EMB_Lib_BlockComment_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
    }

    ;Next i (Needed in the case where oMatch.Value(1) = "")
    i := oMatch.Pos(0) + oMatch.Len(0)

    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }

  return mbsource
}

p_EMB_Lib_Tracer_removeFromString(ByRef src,index,length){
;Supply function with an index and length of a string to extract
;The function will extract and return the string and remove it from the original src string.
out_String := SubStr(src, index, length)
src := SubStr(src,1,index - 1) . SubStr(src,index + length)
return out_String
}

p_EMB_Lib_Tracer_insertIntoString(ByRef src,in_String,index){
;inserts a string "in_String" into src before the index supplied.
;Mid(s,1,Index-1) & "---" & Mid(s,Index)
src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
return
}
