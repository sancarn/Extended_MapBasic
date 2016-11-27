;Main - To be called initially
EMB_Lib_BlockComment(mbsource){
  ;Pattern explanation:
  ;"(?:.|\s)*?"                                                                 ignores all strings
  ;(\/\*(?:.|\s)*?\*\/)                                                         captures /* ... */

  ;*************************************************************************************************************************
  pattern = "(?:.|\s)*?"|(\/\*(?:.|\s)*?\*\/)
  ;*************************************************************************************************************************

  return ForEachPattern(mbsource,pattern,"EMB_Lib_BlockComment_Handler")
}


;oParams[FileName] - settable like: oParams := {FileName: Value1}
EMB_Lib_BlockComment_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

    if (!EMB_Compact_Transpile) {
      ;Convert all lines to comments
      subSrc := RegExReplace(subSrc,"\/\*\s*","'")
      subSrc := StrReplace(subSrc,"`r`n","`r`n'")
      subSrc := RegExReplace(subSrc,"\s*\*\/","`r`n")

      ;Insert commented lines
      Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
    }
  }
  return
}
