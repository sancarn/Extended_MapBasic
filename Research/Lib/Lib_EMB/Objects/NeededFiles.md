# New_GUID

```
'****************************************
'*************** DECLARES ***************
'****************************************
Private Type GUIDStruct
    Data1 As Integer
    Data2 As SmallInt
    Data3 As SmallInt
    Data4(7) As String*1    'Byte
End Type

Declare Function CoCreateGuid Lib "OLE32.DLL" (pGuid As GUIDStruct) As Long

'****************************************

'The function that does all the work:
Public Function New_GUID() As String
    Dim udtGUID As GUIDStruct
    If (CoCreateGuid(udtGUID) = 0) Then
        GetGUID =
            String$(8 - Len(Hex$(udtGUID.data1)), "0") & Hex$(udtGUID.data1) & "-" &
            String$(4 - Len(Hex$(udtGUID.data2)), "0") & Hex$(udtGUID.data2) & "-" &
            String$(4 - Len(Hex$(udtGUID.data3)), "0") & Hex$(udtGUID.data3) & "-" &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) & "-" &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4)) &
            IIf((Asc(udtGUID.data4) < &H10), "0", "") & Hex$(Asc(udtGUID.data4))
    End If
End Function

Private Function Hex$( ByVal nColor as Integer ) as String
    'Definitions
    Dim i as SmallInt, nNibble, nVal as integer, sResult as string
    nVal = nColor

    'Loop through all characters in hex string
    For i = 0 to 7
        nNibble = nVal \ 16 ^ i mod 16
        If nNibble < 10 then
            String$( nNibble,"0" ) + sResult
        Else
             sResult = Chr$( 65 + nNibble - 10 ) + sResult
        End if
    Next

    DecToHex = sResult
End Function

Private Function Iff(Condition as Logical, sTrue as string, sFalse as string) as string
    If Condition Then
        Iff = sTrue
    Else
        Iff = sFalse
    End If
End Function
```
