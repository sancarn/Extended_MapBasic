;Before [DEBUG]

;Main - To be called initially
EMB_Lib_BlockString(mbsource){
  ;Pattern explanation:
  ;"(?:.|\s)*?"                                                                 ignores all strings
  ;\B(\(\"(?:.|\s)*?\"\))                                                        captures (" ... ")

  ;*************************************************************************************************************************
  pattern = "(?:.|\s)*?"|\B(\(\"(?:.|\s)*?\"\))
  ;*************************************************************************************************************************

  return ForEachPattern(mbsource,pattern,"EMB_Lib_BlockString_Handler")
}


;oParams[FileName] - settable like: oParams := {FileName: Value1}
EMB_Lib_BlockString_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

      ;Convert all lines to big string
      subSrc := RegExReplace(subSrc,"\(\""\s*","""")
      subSrc := StrReplace(subSrc,"`r`n",""" & embCrLf &`r`n""")
      subSrc := RegExReplace(subSrc,"\s*\""\)","""")

    ;Insert commented lines
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))

  }
  return
}
