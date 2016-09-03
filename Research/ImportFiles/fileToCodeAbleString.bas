Attribute VB_Name = "fileToCodeAbleString"
Dim TSF As String

Sub init()
  TSF = "4r20ms00000000000s00000e00000W00000W00000100O0000000m00000000000000000000000000004ca76Z70o0850050004ALwIKwD94cayYZ4X84ZCym/3z84ZCym/3z84ZCxm/6T94ca02Z0006XewHewD94ctynq3z84ZCym/3z84cywHdwD94cawUZwPFxNO0ZN0W80000000000007y07z/4cawIZwD93Hs0Lr0K21Kkvekvb44caw+ZuT84ZCym/3z84ZCym/3z84ZCym/3z84ca66Z64h000wG0wD94Z8ynB3z84ZCym/3z84ZBwH2wD94+dvAcv5l0000000000000W00W8vUNzENzEe4cywHdwD94cawkZwfl20W2uW2uL4IQwIPwD94Z8yn83z84ZBym/3z94ZCyi/4984cawIZwD9000wq0wnQ4YlyY74j84ZCyW/4j84cpwT+wPF6+I02H000000000000000uS0uU7wdKwNJw194ZCxm/6T94cawIZwD9vF91Z91WO1Kkvekvb44Ylyc74L94ZCyi/3z84ZCy8/5X94cawIZwD90007a07bW4cawIZwD94cawIZwD94+d7gc7bN0000000000000W00W87ATwMSw194Y+yna3z84ZCym/3z84cawIZwD94cawoZwns0004C048U4caw+ZuT84d9yn53z84ZCym/3z84cawIZwD90007O07Gq4cawIZwD94cawEZw9B1i+00z0000000000002PHwHGwD94ctynq3z84ZCym/3z84ZCym/3z85EhwIcwD94cawIZwD91WO00O0002LIwHIwD94Ylyc74L94ZCyi/4984cawIZwD9000wG0wD94cawIZwD94ca4sZ4mY0000000000857K570w4Y+yna3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCxm/6T94cawIZwD97Qi02i000000vK0vH24caw+ZuT84" & _
        "Z2xDO7v94cawIZwD9085wG5wD94cbwMZwD92ve01c000085vW55Oy4ZCym/3z84ZCym/3z8vTi02P//o/805//z/P4ZCym/3z84ZCym/3z84cywHdwD94ca6kZ6ir0002u02uL4IQwIPwD94cawIZwD94cawIZwD931ivLhvH24cav+Zvv70004q04mY4cayYZ4j84ZCym/3z84ZC6m/vcN/8003///o/800Z///oxhiy+t4jK4ZCym/3z84ZCxm/6T94cawIZwD92jX01X0001Kkvekvb44cawIZwD94cawIZwD94ca2wZ2uL3Tx3vw3qR29DwHCwD94caxoZ6L84ZDym/3z84ZD1e/+VT/8003///o+m67/vuU84ZCyi/3z84dCym/3z84ZCym/3z84cawIZwD94ca6YZ6Wo0002u02uL4cawIZwD94cawIZwD94UV02U0000004q04mY4cawIZw994cayYZ4j84ZCym/3z84ZCv8/7LuzqQ1hd+VTuX/yo73z84ZCym/3z84ZBym/3z94ZCym/3z85IgwIfwD94cawIZwD939e01e0004ALwIKwD94cawEZw991i+00z000000vy0vv74cawMZwD94caw+ZuT84Z8ynB3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCyi/3z84ZBxr26T94cawIZwD94cawIZwD94cawIZwD94cavoZvj542G3wF3qR000000000000vO0vL34cawQZwLE52ewIdwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD962mwIlwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD94cav+Zvv70000000000000000000002u02uL3Tx3vw3qR1Kkv0kuz04cawIZwD94cawIZwD94cawIZwD94cawIZwD91KkvqkvnD4cawIZwD94cawIZwD94cawIZwD94cawMZwD94c" & _
        "awIZwD94ca3wZ3qR0000000000000000000000000000000000000000000000000000000000000000005W05XOyRVx3VwzW0000000000000000000006W06XeuU70270000000000001Kk7ik7et1i+00z0000000000000004q04mY4cawIYwD94ca6oZ6im0850050000000000000000000000000000000005W05XO000000000000000000000000000000000000000000000000000000000000000000000000000v00uz04cawIZwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD92jX01X0000000000004ca66Z64h00000000000000000000000000000000000000000000014H00H0000000000000002u02uL4cawIZwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD931i0Lh0K24cawIZwD94cawIZwD94cawIZwD94cawIZwD94cawIZwD96UpuUpuU70000000000000000000000000004ALwIKwD94cawIZwD94ctynq3z84ZCxy/6584cbwIWwD94cawIZwD94cawIZwD94cawIZwD94cewIQwD94cawIZwD94cawIZwD94cawIZwD94ca0YZ0W80000000000G40040000000000001KkwGkwD94cawIZwD957CynG3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCxm/6T95+mx+i6584ZCxu/6H84cawIZwD94cawIZwD94cawQZwLC4Y101/00029DwHCw994ca66Z64h000000000000vq0vnA4cawIZwD94Ylyo751H4ZCym/3z84ZDym/3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCyi/4984cbwIWwD94+dzgczcruU7" & _
        "0270000000000004UVwIUwD94cawIZwD90000y00y70002u02uL5IgwIfwD94cawIZwD97VAy+L4jK4ZByq/3z84ZCym/3z84ZCym/3z84ZCym/3z84ZCxS/7H94cawUZwPFxNO63N61W0000000000000000004cawIYwD94cawIZwD93PuwHtwD93+F0MF0K261vwfvwbK4cawIZwD94caycZw9z5JFynB3z84ZCyi/3z853Fyn73z84ZCyq/4HB4YqwHxwD94cazsZzow71m01m0000000000000W8vS8vUN4cawIZwD94cav+Zvv74cawIYwD94ca7QZ7Kq0857a57bW5IgwIfwD94cawIZwD94Ylyo74XD4ZCym/3z84ZCym/3z84ZCxW/7PC4cawIZwD94+d62c61W00000000000020020W7QXwIWwD94cawIZwD94ca3wZ3qR4cawIZwD94cawIZwD94ca66Z64h61vwfvwbK4cawIZwD94caw+ZuT853CynF3z84ZCym/3z87ZCwIJwD94cawUZwPF6640230000000000000W8zG8zEf4cawIZwD94cawIZwD94ca02Z0004cawIZwD94cawIZwD94cawIZwD931i39h38M42GwIFwD94cawIZwD94caxEZ7v953CynF3z84cawIZwD94cau2Z7zL00000000000020020W7QXwIWwD94cawIZwD94cawMZwD92nb01Z0004cawIZwD94cawMZwHF4cawIZwD94cawIZwD92jX2vX2uL42GwIFwD94cawIZwD94caxEZ7v94cawIZwD94cX02W0000000000000eDySDyQE4cawIZwD94cawIZwD94cawIZwD90004q04mY4cawIZwD94d1ynR3z84ZCxy/6584cbwIWwD94ca6oZ6im0853u53qR42GwIFwD94cawIZwD95+lvckvX91i+00z0000005u05qp4caw" & _
        "IZwD94ctynq3z84ZCxm/6T94cawIZwD9000vy0vv74cawIZwD94ZCym/3z84ZCym/3z84h1wLRw194cawIZwD94cawIZwD92jX3vX3qR42GwIFwD961W01W0000004q04mY4cawIZwD94cawIZwD94ZCyn13z84ZCym/3z84cawIZwD9000wG0wD94cawIZwD94ZByq/3z84ZCym/3z84ZCym/3z84Y/wLXw194cawIZwD94cawIZwD94ca7IZ7Gq00000000029DwHCwD94cawIZwD94cbx+W6LB4ZCym/3z84ZCyi/4984cawIZwD9000wG0wD94cawIZwD94ZCym/3z8vTi02P//o/805F/x6j4ZCym/3z84ZCym/3z84ZCxy/6584cbwIWwD90004q04mY4cawIZwD94cawMZw194/5ynU3z84ZCym/3z84ZCxC/7v94cawIZwD929DwHCwD94caxUZ7H94ZCym/3z8zqQ03d//o/8003///owrJyon3z84ZCym/3z84ZCym/3z84ZCym/3z8000v00uz04cawIZwD94ouyns3z84ZCym/3z84ZCyq/3z84pDwr3wnQ4cawAZw584cawIZwD94caykZ4984ZCym/3z87oK11w//p/8003///o+q7ypw3z84ZCym/3z84ZCym/3z84ZCym/3z8"
End Sub

Sub test_stringToFile()
    Call init
    
    'EXAMPLE - Write string saved in module to file.
    stringToFile TSF, "C:\Users\jwa\Desktop\sStr.bmp"
End Sub

Sub test_fileToString()
    Call init
    
    'EXAMPLE - Read written file into string. Print whether the strings are equal.
    Debug.Print getProgrammableFileString(64, fileToString("C:\Users\jwa\Desktop\sStr.bmp"), "s")
    Debug.Print fileToString("C:\Users\jwa\Desktop\sStr.bmp") = TSF
End Sub


Sub bin_copyFile(src As String, dest As String)
    Dim sStr As String
    sStr = fileToString(src)
    Debug.Print getProgrammableFileString(64, sStr, "s")
    stringToFile sStr, dest
End Sub



































Sub stringToFile(ByVal strToWrite As String, sFilePath As String)
    Dim strArr() As String
    
    'get array of character pairs
    strArr = splitStringToArray(strToWrite, 3)
    
    'Write binary file
    Dim i As Integer, filePart As Integer
    Dim nFileNum As Integer
    
    ' Get an available file number from the system
     nFileNum = FreeFile
    
    ' Open the file in binary mode.  Locks are optional
    Open sFilePath For Binary Lock Read Write As #nFileNum
       ' Put the data in the file
       For i = LBound(strArr) To UBound(strArr)
         'Write information as integers (THIS IS A MUST!)
         filePart = BaseA_to_Base10(64, strArr(i), True)
         
         ' No byte position is specified so writing begins at byte 1
         Put #nFileNum, , filePart
       Next i
    
    Close #nFileNum
End Sub

Function BaseA_to_Base10(ByVal BaseA As Integer, ByVal Value As String, Optional ByVal signedByte As Boolean) As Integer ' As Long
    Dim char As String, i, e, sum As Long
    Const Base64 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"

    'Find BaseA's character range
    Dim sBaseACharRange As String: sBaseACharRange = Left(Base64, BaseA)

    For i = Len(Value) To 1 Step -1
        char = Mid(Value, i, 1)
        If BaseA > 64 Then
            'Base 256
            e = Asc(char)
        Else
            'Base 0 --> 64
            e = InStr(1, sBaseACharRange, char, vbBinaryCompare) - 1

            'Error -999999 <-- Character is not not found in Base definition
            If e = -1 Then BaseA_to_Base10 = -999999: Exit Function
        End If

        'Calculate sum. This will be eventually returned
        sum = sum + e * BaseA ^ (Len(Value) - i)
    Next i

    'Negatives for signed bytes
    If signedByte And sum > BaseA ^ Len(Value) / 2 Then sum = sum - BaseA ^ Len(Value)

    'Return sum
    BaseA_to_Base10 = sum
End Function

Function splitStringToArray(someString As String, Optional delimitLength As Integer = 1) As String()
    Dim i As Long, j As Long
    Dim strArr() As String
    ReDim strArr(0 To Int(Len(someString) / delimitLength) - 1)
    
    For i = 1 To Len(someString) Step delimitLength
        strArr(j) = Mid(someString, i, delimitLength)
        j = j + 1
    Next i
    
    splitStringToArray = strArr()
End Function

















































Function fileToString(filePath As String) As String
    Dim iIs() As Integer
    Dim i As Integer
    Dim sBig As String
    
    iIs = ReadBinaryFile(filePath)
    
    'Loop and send to Base A
    For i = LBound(iIs) To UBound(iIs)
        'Accumulate string
        sBig = sBig & Base10_to_BaseA(64, iIs(i), True, 3)
    Next i
    
    'Send base A to file
     fileToString = sBig
End Function

Function ReadBinaryFile(sFileName As String) As Integer()
    Dim iValue() As Integer
    Dim iCount As Integer
    Dim nFileNum As Integer
    'Dim sFilename As String
    Dim x As Integer
    
    
    'sFilename = "U:\Macros\3_AHK\Smart MapBasic Compiler\asdf.bmp"
    
    ' Get an available file number from the system
     nFileNum = FreeFile
    
    ' Open the file in binary mode.  Locks are optional
    Open sFileName For Binary Lock Read Write As #nFileNum
    
      ' Get the data from the file
       Do Until EOF(nFileNum)
         Debug.Assert Not EOF(nFileNum)
         ' Make room in the array for the next value
        ReDim Preserve iValue(iCount)
    
         ' No byte position is specified so reading starts at byte 1
         Get #nFileNum, , iValue(iCount)
    
         ' Increment counter
         iCount = iCount + 1
       Loop
    
    Close #nFileNum
    
    'This is here due to an observation that the last character which is pulled out of the file is a null character.
    'Thus we need to remove this byte of information to get an exact copy of the file's bits.
    ReDim Preserve iValue(UBound(iValue) - 1)
    
    ReadBinaryFile = iValue
End Function

'Recall Max length of a string in MapBasic is 32, 768 characters. In VBA the limit is 2GB?
Function Base10_to_BaseA(ByVal BaseA As Integer, ByVal Value As Long, Optional ByVal signedByte As Boolean, Optional ByVal fixedLength As Integer) As String
    'Define character range
    Const Base64 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
    Dim i As Long
    
    If signedByte Then
        'If fixedLength is less than or equal to 0, error
        'Signed bytes have to have a declared length, as this is used in the declaration of their value
        If fixedLength <= 0 Then
            Base10_to_BaseA = "#Error - Signed byte must have declared length"
            Exit Function
        End If
        
        'If value is overflowing/underflowing out of +/- then throw error
        If Value < 1 - BaseA ^ fixedLength / 2 Then
            Base10_to_BaseA = "#Error - Underflow in signed byte"
            Exit Function
        ElseIf Value > BaseA ^ fixedLength / 2 Then
            Base10_to_BaseA = "#Error - Overflow in signed byte"
            Exit Function
        End If
        
        'Use A's compliment
        If Value < 0 Then
            Value = BaseA ^ fixedLength + Value
        End If
    End If  'End isSignedByte
    
    'Create string
    While Value <> 0
        'Get the BaseA-it magnitude (in base 10)
        i = Value Mod BaseA
        
        'Note in this function we get the BaseA-it's in reverse
        If BaseA <= 64 Then
                returnString = Mid(Base64, i + 1, 1) & returnString
        Else
                returnString = Chr(i) & returnString
        End If
        
        'Go further into the number
        Value = Int(Value / BaseA)
    Wend
    
    If fixedLength = 0 Then Base10_to_BaseA = returnString: Exit Function
    
    'If length of returned string is greater than fixed length throw error
    If Len(returnString) > fixedLength Then
        Base10_to_BaseA = "#Error - Fixed Length Overflow"
    ElseIf Len(returnString) = fixedLength Then
        Base10_to_BaseA = returnString
    Else
        Base10_to_BaseA = String(fixedLength - Len(returnString), "0") & returnString
    End If
End Function

Function getProgrammableFileString(base As Integer, fileString As String, variableName As String)
    'Function to easily get a programmable string to insert into alternate code
    Dim i As Long, returnString As String
    If base > 64 Then
        
        MsgBox "ERROR - WIP"
        Exit Function
        
    Else
        returnString = "Dim " & variableName & " As String"
        For i = 0 To Int(Len(fileString) / 1000)
            returnString = returnString & vbCrLf & variableName & " = " & variableName & " & """ & Mid(fileString, i * 1000 + 1, 1000) & """"
        Next i
    End If
    
    getProgrammableFileString = returnString
End Function

















































'*****************************************************************'
'*                       TESTING FUNCTIONS                       *'
'*****************************************************************'
Function FileToSHA1Hex(sFileName As String) As String
    Dim enc
    Dim bytes
    Dim outstr As String
    Dim pos As Integer
    Set enc = CreateObject("System.Security.Cryptography.SHA1CryptoServiceProvider")
    'Convert the string to a byte array and hash it
    bytes = GetFileBytes(sFileName)
    bytes = enc.ComputeHash_2((bytes))
    'Convert the byte array to a hex string
    For pos = 1 To LenB(bytes)
        outstr = outstr & LCase(Right("0" & Hex(AscB(MidB(bytes, pos, 1))), 2))
    Next
    FileToSHA1Hex = outstr 'Returns a 40 byte/character hex string
    Set enc = Nothing
End Function

Private Function GetFileBytes(ByVal path As String) As Byte()
    Dim lngFileNum As Long
    Dim bytRtnVal() As Byte
    lngFileNum = FreeFile
    If LenB(Dir(path)) Then ''// Does file exist?
        Open path For Binary Access Read As lngFileNum
        ReDim bytRtnVal(LOF(lngFileNum) - 1&) As Byte
        Get lngFileNum, , bytRtnVal
        Close lngFileNum
    Else
        Err.Raise 53
    End If
    GetFileBytes = bytRtnVal
    Erase bytRtnVal
End Function
