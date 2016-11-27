
#Include ForEachPattern.AHK

FileSelectFile, SelectedFile, 3
FileRead,issues,%SelectedFile%

issues := ThisFunc(issues)

FileAppend, %issues%, %A_WorkingDir%\issues2.txt

;msgbox, %mbsource%

;FileAppend,`r`n`r`n-----------------------------------------------------------`r`n`r`n%mbsource%,%SelectedFile%

Msgbox, All Done!

ThisFunc(issues){
  ;Pattern explanation:
  ;utils.iqt()                                                                  ignores quoted text
  ;debug\.(?:print\s+.+(\s*MBOps.+)*                                            captures debug.print ... {someMBOperator} ...

  ;*************************************************************************************************************************
  pattern = "body": "(\s|.*?)[^\\"]"
  ;*************************************************************************************************************************

  issues := ForEachPattern(issues,pattern,"HANDLER")

  return issues
}

HANDLER(byref issues, oMatch, oParams){

  substr := Transpiler_removeFromString(issues,oMatch.Pos(1), oMatch.Len(1))
    substr := RegExReplace(substr,"\n","\n")
  ;msgbox, %substr%
  Transpiler_insertIntoString(issues,subSrc,oMatch.Pos(1))
}
