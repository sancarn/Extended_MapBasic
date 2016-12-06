# Dealing with Hexadecimal

One of the proposed methods of storing file data is to use Hexadecimal strings. To do so we really need to know how we can convert these hexadecimal strings in MapBasic to their representative value.

## Convert hexadecimal to decimal

The `Val()` function is quite a handy one! It allows values such as `"18"` to be converted into their integer form `18`, and even allows `"0.123"` to be converted into it's decimal/float representation `0.123`.

One of the lesser known functionalities of the `Val()` function is its ability to translate hexadecimal strings into their integer representations. For example:

```
Print "&H1A" + 3 'Prints "263" to the message window

Print Val("&H1A") + 3 'Prints "29" to the message window
```

This should satisfy all the requirements for the writing of files from hexadecimal strings.

## Convert decimal to hexadecimal

It may also be useful to be able to convert data into hexadecimal. Though this may not be immediately obvious it is mainly useful when wanting to create GUIDs from fully random OS functions.

```{MB}
Function DecToHex( byval nColor as integer ) as String
    'Definitions
    Dim i as smallint, nNybble, nVal as integer, sResult as string

    '
    nVal = nColor

    '
    For i = 0 to 7
        nNybble = nVal \ 16 ^ i mod 16
        If nNybble < 10 then
            String$( nNybble,"0" ) + sResult
        Else
             sResult = chr$( 65 + nNybble - 10 ) + sResult
        End if
    Next

    DecToHex = sResult
End Function
```
