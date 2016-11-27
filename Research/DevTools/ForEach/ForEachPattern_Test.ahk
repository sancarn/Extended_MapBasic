
#Include ForEachPattern.AHK
#Include EMB_BLockComment.AHK
#Include EMB_BLockStrings.AHK
#Include EMB_Tracer.AHK

FileSelectFile, SelectedFile, 3, , Open a mb file, MapBasic Files (*.mb)
FileRead,mbsource,%SelectedFile%
RegexMatch(SelectedFile,"[^\\]*(?=[.][a-zA-Z]+$)",Match)
Transpile_Params := {"FileName":Match}

mbsource := EMB_Lib_BlockComment(mbsource)
mbsource := EMB_Lib_BlockString(mbsource)
mbsource := EMB_Lib_Tracer(mbsource)

msgbox, %mbsource%

;FileAppend,`r`n`r`n-----------------------------------------------------------`r`n`r`n%mbsource%,%SelectedFile%

Msgbox, All Done!
