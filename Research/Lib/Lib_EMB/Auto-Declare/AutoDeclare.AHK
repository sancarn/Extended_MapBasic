EMB_Lib_AutoDeclare(mbsource){
  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;\bDeclare\s+Sub\s+\w+\($args$\)|\bDeclare\s+Function\s+\w+\($args$\)\s+as\s+\w+  captures [Declare Sub ...($args$)] and [Declare Function ...($args$) as ...]
  ;utils.insertDeclarationArgs(pattern,"$args$")                                captures arguments of declarations. E.G. (a as b, c as d, e as f)

  ;*************************************************************************************************************************
  pattern = \bDeclare\s+Sub\s+\w+\($args$\)|\bDeclare\s+Function\s+\w+\($args$\)\s+as\s+\w+
  utils.insertDeclarationArgs(pattern,"$args$")
  utils.iqt(pattern)
  ;*************************************************************************************************************************

  mbsource := ForEachPattern(mbsource,pattern,"EMB_Lib_AutoDeclare_DeclareRemoval_Handler")

  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;\bSub\s+\w+\($args$\)|\bFunction\s+\w+\($args$\)\s+as\s+\w+                  captures [Sub ...($args$)] and [Function ...($args$) as ...]
  ;utils.insertDeclarationArgs(pattern,"$args$")                                captures arguments of declarations. E.G. (a as b, c as d, e as f)

  ;*************************************************************************************************************************
  pattern = \bSub\s+\w+\($args$\)|\bFunction\s+\w+\($args$\)\s+as\s+\w+
  utils.insertDeclarationArgs(pattern,"$args$")
  utils.iqt(pattern)

  mbsource := ForEachPattern(mbsource,pattern,"EMB_Lib_AutoDeclare_DeclareCreate_Handler")

  ;Append Include onto beginning of mbsource document
  mbsource = Include "Extended_MapBasic.def"`r`n%mbsource%
  return mbsource
}

EMB_Lib_AutoDeclare_DeclareRemoval_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    ;Remove declare from MapBasic file
    Transpiler_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))
  }
}

EMB_Lib_AutoDeclare_DeclareCreate_Handler(ByRef mbsource, oMatch, oParams){
  If oMatch.Value(1) {
    utils.AppendDef("Declare " . oMatch.Value(1))
  }
}
