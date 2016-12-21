# Variable Naming in MapBasic

## Preface
This document covers the ASCII characters that can be part of a MapBasic variable name.

## Character available depends on position in name.

It is common knowledge that you can't start MapInfo column names with a digit. This also extends to variable names in MapBasic. So the first thing to find out is **Which characters can you start a MapBasic variable name with?**

### Characters at the start of a variable name

The characters that can lie at the start of a MapBasic variable name are:

```
A to Z
a to z
_
~
ASCII(128) to ASCII(255)
```

The RegEx to find these characters can be given by: `[a-zA-Z_~\x80-\xFF]`

### Characters after the start of a variable name

The characters that can lie in the middle of a MapBasic variable name are:

```
ASCII(9)
ASCII(20)
!
#
$
%
&
0 to 9
A to Z
a to z
_
~
ASCII(128) to ASCII(255)
```

You may notice that these largely include the characters at the start, but with a few additions. I.E.:

```
ASCII(9)
ASCII(20)
!
#
$
%
&
0 to 9
All starting characters
```

This leads to this regex:
The RegEx to find these characters can be given by: `(?:[a-zA-Z_~\x80-\xFF]|[0-9@&%$#!\x20\x0C\x09])`
Alternative *compressed* RegEx: `[0-9@&%$#!\x20\x0C\x09a-zA-Z_~\x80-\xFF]`

## Finding "full" variable names

Any MapBasic variable written under Windows-Latin character set (ASCII) will be targetable with the following RegEx:

```
[a-zA-Z_~\x80-\xFF](?:[a-zA-Z_~\x80-\xFF]|[0-9@&%$#!\x20\x0C\x09])*
```

Alternative Compressed RegEx: `[a-zA-Z_~\x80-\xFF][0-9@&%$#!\x20\x0C\x09a-zA-Z_~\x80-\xFF]*`
