FileRead, ToDoList, TODO.md
FileRead, README, README.md

Pattern := "[//]: <> (BEGIN TODO LIST)"
EndPattern := "[//]: <> (END TODO LIST)"

Pos := InStr(README,Pattern) - 1
StringLeft,Pt1,README,%Pos%

Pos := InStr(README,EndPattern) + strlen(EndPattern)
StringMid,Pt2,README,%Pos%



FileDelete, README.md
FileAppend, %Pt1%%Pattern%`r`n%ToDoList%%EndPattern%%Pt2%, README.md
