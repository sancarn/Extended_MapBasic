# Block Strings

A block string, follows the same concept as block commenting however it assigns a block of strings to a specific variable. For example:

```
var = 
(
First line of string
Second line of string
Third line of string
)
msgbox, %var%
```

The example code above will display a message box containing the message:

```
First line of string
Second line of string
Third line of string
```

It is important to note however that if we converted all the `carriage-return`s to `\r` and all the `line-feed`s to `\n` of the above variable we would get:

```
First line of string\nSecond line of string\nThird line of string
```

I.E. `Var` contains no `Carriage-Return`s!

In contrast if we use:

```
fileread, Var, myText.txt
```

with myText.txt containing:

```
First line of string
Second line of string
Third line of string
```

`Var` would contain both `Carriage-Return`s and `Line-Feed`s
