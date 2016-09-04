;In the Header we define declares which need to be added to the Header of the script (or to the .def files if they exist)
Header := "
Declare Sub stringToFile(ByVal strToWrite As String, ByVal sFilePath As String)
Declare Function BaseA_to_Base10(ByVal BaseA As Integer, ByVal Value As String, ByVal signedByte As Logical) As SmallInt 'as long
Declare Sub splitStringToArray(ByVal someString As String, ByVal delimitLength As Integer, strArr() as string)
"

;In the footer we define the inner workings of the functions/subroutines declared in header
Footer := "
'~~~~~~~~~~~~~~~~~~~~~~~~~~ GENERATED BY EMB INCLUDEFILE ~~~~~~~~~~~~~~~~~~~~~~~~~~
Sub stringToFile(ByVal strToWrite As String, ByVal sFilePath As String)
	Dim strArr() As String
	
	'get array of character pairs		'splitStringToArray sub-routine ported to MapBasic
	Call splitStringToArray(strToWrite, 3, strArr)
	
	'Write binary file
	Dim i As Integer, filePart As SmallInt, nFileNum As Integer
	
	If Not FileExists(sFilePath) then
		Open File sFilePath for Output as #1
		Close File #1
	End If
	
	' Open the file in binary mode.  Locks are optional
	Open File sFilePath For Binary Access Read Write As #1
	   ' Put the data in the file
	   For i = 1 To UBound(strArr)
		   'Write information as integers (THIS IS A MUST!)
		   filePart = BaseA_to_Base10(64, strArr(i), 1)
		 
		   ' No byte position is specified so writing begins at byte 1
		   Put #1, , filePart
	   Next
	Close File #1
End Sub

Function BaseA_to_Base10(ByVal BaseA As Integer, ByVal Value As String, ByVal signedByte As Logical) As SmallInt
	Dim char As String, i, e, sum As Integer
	Define Base64 "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
	
	'Find BaseA's character range
	Dim sBaseACharRange As String
	sBaseACharRange = Left$(Base64, BaseA)
	
	For i = Len(Value) To 1 Step -1
		char = Mid$(Value, i, 1)
		If BaseA > 64 Then
			'Base 256
			e = Asc(char)
		Else
			'Base 0 --> 64
			e = InStr(1, sBaseACharRange, char) - 1
	
			'Error -999999 <-- Character is not not found in Base definition
			If e = -1 Then
				  BaseA_to_Base10 = -999999
				  Exit Function
			  End If
		End If
	
		'Calculate sum. This will be eventually returned
		sum = sum + e * BaseA ^ (Len(Value) - i)
	Next
	
	'Negatives for signed bytes
	If signedByte And sum > BaseA ^ Len(Value) / 2 Then
		sum = sum - BaseA ^ Len(Value)
	End If
	
	'Return sum
	BaseA_to_Base10 = sum
End Function


Sub splitStringToArray(ByVal someString As String, ByVal delimitLength As Integer, strArr() as string)
	Dim i As Integer, j As Integer
	j = 1
	
	ReDim strArr(Int(Len(someString) / delimitLength))
	
	For i = 1 To Len(someString) Step delimitLength
		strArr(j) = Mid$(someString, i, delimitLength)
		j = j + 1
	Next
End Sub
"

;~~~~~~~~~~~~~~~~~~~~~~~~~~ EMB INCLUDEFILE ~~~~~~~~~~~~~~~~~~~~~~~~~~
;Developers: Sancarn
;Contributors: 
;GUID: {}

;TODO:
  ; filepath variable declarations
  ; filedata variable declarations
  ; getFileData
  ; concatenate with MB

;String to do actions on is MBSource
MB := MBSource
sFilePaths := []
sFileVars := []


;Main Regex: Include\s+"(.*)"\s*,\s*(\w+)\s+as\s+string
pattern := "iO)" . "Include\s+"((?!.*Include).*?)"\s*,\s*(\w+)\s+as\s+string"

;What does the regex mean?
;~~~~~~~~~~~~~~~~~~~~~~~~~
;The desired match should consist of 'Include "<some characters>" , <some variable name> as string'
;The following is an illegal match 'Include "<some characters> Include" , <some variable name> as string'
;Prefix Option "i" makes the regex case insensitive.
;Prefix Option "O" makes the regex return an object.
;The following match is legal: 'Include "someImage.png", someImage as string' in 'Include "someScript.mb"Include "someImage.png", someImage as string'

;Test this regex
;~~~~~~~~~~~~~~~~~~~~~~~~~
;https://regex101.com/r/zA3tP7/1

match = RegExMatch(MB, pattern, mObj, 1)

If match <> "" {
   while match <> ""
   {
      ;Get captured strings
      sFilePaths.push(match1)
      sFileVars.push(match2)
      
      ;Remove the match from MB
      MB := ImportFiles_MidInvert(MB,match, mObj.Len()) 
      
      ;Find the next match
      match = RegExMatch(MB, pattern, mObj, match)
   }
  
  ;All 'Include "someFile", asdf as string' have been removed from MB. MB therefore contains the 'most complete' script so far
  ;Next steps, generate
  ; filepath variable declarations
  ; filedata variable declarations
  ; getFileData
  ; concatenate with MB
}





ImportFiles_MidInvert(sSrc, iStart, iLen){
  ;This function does the oppisite of mid. Instead of extracting a part of a string and returning the extracted part, in this case we are returning the part after extraction. You can imagine this as if we were replacing the string returned from mid() with null.
  ;Examples
  ;~~~~~~~~~~~~~~~~
  ;MidInvert("https://regex101.com/r/zA3tP7/1",6,11)  returns "https.com/r/zA3tP7/1"
  ;MidInvert("https://regex101.com/r/zA3tP7/1",1,8)   returns "regex101.com/r/zA3tP7/1"
  ;MidInvert("https://regex101.com/r/zA3tP7/1",30,8)  returns "1"
  
  ;If iStart is less than 1 then there is no leftPart
  if (iStart > 1){
    leftPart := subStr(sSrc,1,iStart-1)
  }
  
  ;If iStart+iLen is greater than the length of the string, there can't be a right part
  if iStart+iLen >= strlen(sSrc){
    rightPart := subStr(sSrc,iStart + iLen)
  }
  
  ;Return concatenation of the left and right parts.
  return leftPart . rightPart
}
