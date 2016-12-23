;Main - To be called initially
EMB_Lib_UpdateWhere(mbsource){
  ;Pattern explanation:
  ;"(?:.|\s)*?"                                                                 ignores all strings
  ;(\/\*(?:.|\s)*?\*\/)                                                         captures /* ... */

  ;*************************************************************************************************************************
  pattern = Update (\var\) Set (\equation\) where (\equation\)
  ;*************************************************************************************************************************

  return ForEachPattern(mbsource,pattern,"EMB_Lib_UpdateWhere_Handler")
}


;oParams[FileName] - settable like: oParams := {FileName: Value1}
EMB_Lib_UpdateWhere_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))


      ;Convert all lines to comments
      subSrc = Select * From TABLE Where CONDITIONAL Into œTempUpdateTable  Update œTempUpdateTable Set SET_EQUATION  Close Table œTempUpdateTable
      subSrc := StrReplace(subSrc,"TABLE",oMatch.Value(1))
      subSrc := StrReplace(subSrc,"CONDITIONAL",oMatch.Value(3))
      subSrc := StrReplace(subSrc,"SET_EQUATION",oMatch.Value(2))

    ;Insert commented lines
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))

  }
  return
}
