#SingleInstance, Force
#Include EMB_Core_BlockComment.ahk
EMB_Compact_Transpile := 0

FileRead, mbsource, someMB.txt



mbsource := EMB_Core_BlockComment(mbsource)
FileAppend, `r`n`r`n-----------------------------------------------------------`r`n`r`n, someMB.txt
FileAppend, %mbsource%, someMB.txt

return

