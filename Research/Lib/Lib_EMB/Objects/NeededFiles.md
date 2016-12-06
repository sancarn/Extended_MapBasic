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

# Class Declares

```
Type MyClass_Type
  ThisParentID as string
  ThisChildrenIDs(1) as string
  ThisMethods(%NumMethods%) as string
  ThisName as string
  ThisGUID as string

  property1 as type1
  property2 as type2
  ...
End Type
```

```
Function MyClass_New() as MyClass_Type
  Dim O as MyClass_Type

  'Initiate type from class constructor default values:
  'O.property1 = ...
  'O.property2 = ...
  O.ThisParentID = 0
  O.ThisChildrenIDs(1) = "..."
  O.ThisChildrenIDs(2) = "..."
  '...
  O.ThisMethods(1) = "..."
  O.ThisMethods(2) = "..."
  '...
  O.ThisName = "MyClass"
  O.ThisGUID = New_GUID()

  Call MyClass_setValues(O)
  MyClass_New = O
End Function
```

```
Sub MyClass_setValues(O as MyClass_Type)
  'Counter variable if required
  Dim i as integer

  'This routine should ONLY be called if the object is to be used later on.
  'Finally create a Global Object from it's GUID (somehow)
  'Using metadata tables:
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\GUID" to O.ThisGUID

  'User properties !!! REMEMBER SPECIAL CASE FOR ARRAYS !!!
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\property1\value" to O.property1
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\property1\type" to "type1"

  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\property2\value" to O.property2
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\property2\type" to "type2"
  '...

  'User property arrays: (assuming MyClass_Type.Property_Arr)
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\Property_Arr\length\value" to UBound(O.Property_Arr)
  Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\Property_Arr\type" to "..."
  For i = 1 to UBound(O.Property_Arr)
    Metadata Table %EMB_MBXName%_AppObjects SetKey "\AppObjects\MyClass\" & O.ThisGUID & "\Properties\Property_Arr\" & i & "\value" to O.PropertyArr(i)
  Next
  '...
End Sub
```

# General Object Declarations

```
Sub Release_Object(O as MyClass_Type)
  Metadata Table %EMB_MBXName%_AppObjects DroHpKey "\AppObjects\" & O.ThisName & "\" & O.ThisGUID Hierarchical
End Sub
```
