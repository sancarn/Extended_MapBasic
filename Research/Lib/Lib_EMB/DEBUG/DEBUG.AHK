;Require Block_Commenting

;Main - To be called initially
Global EMB_Lib_Debug_Const

EMB_Lib_Debug(mbsource){
  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;debug\.(?:print\s+.+(\s*MBOps.+)*                                            captures debug.print ... {someMBOperator} ...

  ;*************************************************************************************************************************
  pattern = debug\.(?:print\s+.+(\s*MBOps.+)*
  insertMBOperators(pattern,MBOps)
  utils.iqt(pattern)
  ;*************************************************************************************************************************

  mbsource := ForEachPattern(mbsource,pattern,"EMB_Lib_Debug_Print_Handler")

  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;debug\.assert\s+(?:.+\s*MBOps\s*.+)*                                         captures debug.assert ... {someMBOperator} ...

  ;*************************************************************************************************************************
  pattern = debug\.assert\s+(?:.+\s*MBOps\s*.+)*
  insertMBOperators(pattern,MBOps)
  utils.iqt(pattern)
  ;*************************************************************************************************************************

  mbsource := ForEachPattern(mbsource,pattern,"EMB_Lib_Debug_Assert_Handler")

  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;debug\.choose(\((?:[^()]|(?1))*\))                                           captures debug.choose(... , ...) including when ... contains brackets

  ;*************************************************************************************************************************
  pattern = debug\.choose(\((?:[^()]|(?1))*\))
  utils.iqt(pattern)
  ;*************************************************************************************************************************

  mbsource := ForEachPattern(mbsource,pattern,"EMB_Lib_Debug_Choose_Handler")
}


;oParams[FileName] - settable like: oParams := {FileName: Value1}
EMB_Lib_Debug_Print_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

    ;Determine which debug function the extracted subSrc
    If (EMB_Lib_Debug_Const){
      subSrc := "Print" . oMatch.Value(1)
    } else {
      ;Leave for Comment system to transpile the code
      subSrc := "/*Print" . oMatch.Value(1) . "*/"

    }
    ;Re-insert subSrc
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
  }
}

EMB_Lib_Debug_Assert_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

      ;Get assertion from captured group
      Assertion := oMatch.Value(1)

      ;Define assertion code
      if (EMB_Lib_Debug_Const){
;*************************************************
subSrc =
(
if %Assertion% then
  stop
end if
)
;*************************************************
      } else {
          subSrc = /*%subSrc%*/
      }

    ;Re-insert subSrc
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
  }
}

EMB_Lib_Debug_Choose_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;get captured pattern
    subSrc := Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))

      ;Delimit the choose variables with RegEx
        ;match all " ... "
        ;match all ( ... )
        ;capture all other ,
      pattern = "(?:.|\s)*?"|\((?:.|\s)*?\)|(,)
      chooseComponents := []

      ;Loop through matches from pattern and append captured groups
      ForEachPattern(chooseComponents,pattern,"p_EMB_Lib_Debug_ChoosePart_Handler")

      ;If Debug return component 0 else return component 1
      subSrc := EMB_Lib_Debug_Const ? chooseComponents[0] : chooseComponents[1]

    ;Re-insert subSrc
    Transpiler_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
  }
}

p_EMB_Lib_Debug_ChoosePart_Handler(byref chooseComponents, oMatch, oParams){
  chooseComponents.push(oMatch.Value(1))
}
