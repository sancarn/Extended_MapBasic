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

## How the Put Statement acts:

To find out how to input bytes of data into files we need to do an analysis of the data returned from each of the file writing statements.

### `Logical` data-type:
Documented as being able to insert single bytes of data. Any non-zero character written to a file from a logical variable, will be inputted as `00000001`. Logical values of 0 will be inputted as `00000000`.

Example:

```
Dim fs as string
fs = "C:\Users\jwa\Desktop\TBD\MiWrite\hello.txt"

Dim k as Logical
Open File fs for binary as #1
    k=asc("H")
    Put #1,1,k
    k=asc("e")
    Put #1,1,k
    k=asc("l")
    Put #1,1,k
    k=asc("l")
    Put #1,1,k
    k=asc("o")
    Put #1,1,k
Close File #1  
```

File Contents:

```
01
01
01
01
01
```

### `Integer` data-type

Documented as being able to insert 4 bytes of data at a time. I would assume this would mean that every number that is written is will write 4 bytes of data. E.G. writing `5` would write `00000000 00000000 00000000 00000101`. However this is not the case. Here's an example:

```
Dim fs as string
fs = "C:\Users\jwa\Desktop\TBD\MiWrite\hello.txt"

Dim k as Integer
Open File fs for binary as #1
    k=asc("H")
    Put #1,1,k
    k=asc("e")
    Put #1,1,k
    k=asc("l")
    Put #1,1,k
    k=asc("l")
    Put #1,1,k
    k=asc("o")
    Put #1,1,k
Close File #1  
```

If I look at the file in a Hex Editor, we can see the following bytes.

```
48
65
6c
6c
6f
00
00
00
```
