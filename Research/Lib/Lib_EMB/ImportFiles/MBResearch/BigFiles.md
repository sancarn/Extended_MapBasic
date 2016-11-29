# Problem

MapBasic has a 32,767 character limit. For most use cases this isn't a problem however in the cases of BigFiles this does become rather of a problem! After all 32,767 characters is only (at max) 32, 767 bytes of storage (only 32.7 kB). That's also assuming we can store any character in a code file. However I assume we will have to store all characters as HEX instead which halfs the total available space (total of roughly 16kb)

## Testing character limit of a string

```
Dim i as integer
Dim s as String
For i = 1 to 100000
	s = string$(i,"a")
  Print Chr$(12)
	Print i
Next
```

# Partial solution - Arrays

## Finding array size limit

```
Dim i as integer
Dim s(1) as String
For i = 1 to 100000
	Redim s(i)
	s(i) = "hello world"
  Print Chr$(12)
	Print i
Next
```

This results in the finding that the array size limit is also 32,767. Interested in the potential use of this with file storage I explored whether an array of this size could also store strings of length 32,767.

## Finding max size of an array of byte arrays:

```
Dim i as integer
Dim s(1) as String
For i = 1 to 100000
	Redim s(i)
	s(i) = string$(32767,"a")
	Print Chr$(12)
	Print i
Next
```

Results show that a string array can hold `32767` strings each of length `32767` giving a total byte size of `32767*32767 bytes = 1,073,676,289 bytes = 1.07 GB`.

# Full Solution

1.07 GB is a lot of memory however there may be times where users will want to store files larger than 1.07 GB.
It must also be noted that storing this file size in a byte array is very memory intensive and a sure fire way of forcing MapBasic into a state where it runs out of RAM.

A better solution would be to restrict the number of these arrays to 1, but wherever files are required generate sub-routines to initialise the arrays when needed.

```
Dim sFileContents(32767) as String
Dim iFileArrayCount as integer

Sub WriteFileContents(sRef as string,sPath as string)
  'Take up a new portion of memory
  Redim sFileContents(32767)
  
  'Get iFileArrayCount
  CallSubByName(sRef & "_GetCount")
  
  'Loop through file contents and export to file
  For i = 1 to iFileArrayCount
    CallSubByName(sRef & "_" & i)
    WriteArrayToFile(sFileContents,sPath)
  Next
  
  'Restore memory
  Redim sFileContents(0)
End Sub

Sub sFile1_1()
  'First part of File 1
  sFileContents(1) = ...
  sFileContents(2) = ...
  sFileContents(3) = ...
  ...
End Sub

Sub sFile1_2()
  'Second part of File 1
  sFileContents(1) = ...
  sFileContents(2) = ...
  sFileContents(3) = ...
  ...
End Sub

Sub sFile2_1()
  'First part of File 2
  sFileContents(1) = ...
  sFileContents(2) = ...
  sFileContents(3) = ...
  ...
End Sub

'...
```

This system would allow files much bigger than 1.07 GB being written while still being mostly energy efficient
