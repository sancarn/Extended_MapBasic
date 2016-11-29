# AHK - Import Files

This folder will contain all sub-routines and functions, .MB, .BAS and .AHK files, to write files into .MBs.

This will be used for the custom include statement:

```
Include "C:\myfile.png", filePath as string
```

From this point filePath will represent a real file path for "myfile.bas"

When we transpile to .MB we will transpile it to code like this:

```
If fileexist("C:\myfile.bas" then
   filePath = "C:\myfile.bas"
else
    filePath = makeFile(<GUID>)
End If

Dim <GUID> as string
<GUID> = hex(<fileContents>)

Sub makeFile(fileContents as string)
...
End Sub
```
