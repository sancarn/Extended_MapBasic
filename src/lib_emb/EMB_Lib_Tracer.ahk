;Before [DEBUG]

;Main - To be called initially
EMB_Lib_Tracer(mbsource){
  ;Pattern explanation:
  ;".*?(?:sub|function)\s+.+?\(.*?"                                             ignores [Print "sub ... "] or [Print "Function ..."]
  ;End\s+(?:sub|function)                                                       ignores [End Sub] or [End Function]
  ;Declare\s+(?:sub|function)                                                   ignores [Declare Sub] or [Declare Function]

  ;(sub\s+.+?\((?:.|\s)*?\))|(function\s+.+?\((?:.|\s)*?\)\s+as\s+\w+)          captures [Sub .+(.*)] and [Function .+(.*) as .+]

  ;*************************************************************************************************************************
  pattern = ".*?(?:sub|function)\s+.+?\(.*?"|End\s+(?:sub|function)|Declare\s+(?:sub|function)|(sub\s+.+?\((?:.|\s)*?\))|(function\s+.+?\((?:.|\s)*?\)\s+as\s+\w+)
  ;*************************************************************************************************************************

  return ForEachPattern(mbsource,pattern,"EMB_Lib_Tracer_Handler")
}

;oParams[FileName] - settable like: oParams := {FileName: Value1}
EMB_Lib_Tracer_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) or oMatch.Value(2) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

      ;Get the function/sub name
      RegexMatch(subSrc,"i)(?:Sub|Function)\s+(.*?)\(",Match)

      ;Insert the stack tracer statement
      subSrc := subSrc . "`r`n" . "Debug.Print """ . oParams["FileName"] . "." . Match1 . """"

    ;Insert new subSrc
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
  }
  return
}
