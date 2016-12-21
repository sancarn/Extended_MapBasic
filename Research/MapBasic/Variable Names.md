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
!
#
$
%
&
0 to 9
All starting characters
```

This leads to this regex:
The RegEx to find these characters can be given by:

`(?:[a-zA-Z_~\x80-\xFF]|[0-9@&%$#!\x0C\x09])`

Alternative *compressed* RegEx:

`[0-9@&%$#!\x20\x0C\x09a-zA-Z_~\x80-\xFF]`

## Finding possible "full" variable names

Any MapBasic variable written under Windows-Latin character set (ASCII) will be targetable with the following RegEx:

```
[a-zA-Z_~\x80-\xFF](?:[a-zA-Z_~\x80-\xFF]|[0-9@&%$#!\x0C\x09])*
```

Alternative Compressed RegEx:

`[a-zA-Z_~\x80-\xFF][0-9@&%$#!\x0C\x09a-zA-Z_~\x80-\xFF]*`

## Limitations:

As specified in the MapBasic reference:

> Many MapBasic language keywords, such as Open, Close, Set, and Do, are reserved words which may
not be used as variable names. If you attempt to define a variable called Set, MapBasic will generate
an error when you compile the program.

These variable names can be found in the list below:

```
Add,Alter,Browse
Call,Close,Create,DDE
DDEExecute,DDEPoke,DDETerminate,DDETerminateAll
Declare,Delete,Dialog,Dim
Do,Drop,Else,ElseIf
End,Error,Event,Exit
Export,Fetch,Find,For
Function,Get,Global,Goto
Graph,If,Import,Insert
Layout,Map,Menu,Note
Objects,OnError,Open,Pack
Print,PrintWin,ProgressBar,Put
ReDim,Register,Reload,Remove
Rename,Resume,Rollback,Run
Save,Seek,Select,Set
Shade,StatusBar,Stop,Sub
Type,Update,While
```

This list should also includes `UnDim`

Ideally our RegEx would disallow these, I haven't worked out how, but this should help:

```
(?!Add|Alter|Browse|Call|Close|Create|DDE|DDEExecute|DDEPoke|DDETerminate|DDETerminateAll|Declare|Delete|Dialog|Dim|Do|Drop|Else|ElseIf|End|Error|Event|Exit|Export|Fetch|Find|For|Function|Get|Global|Goto|Graph|If|Import|Insert|Layout|Map|Menu|Note|Objects|OnError|Open|Pack|Print|PrintWin|ProgressBar|Put|ReDim|Register|Reload|Remove|Rename|Resume|Rollback|Run|Save|Seek|Select|Set|Shade|StatusBar|Stop|Sub|Type|Update|While|UnDim)
```

## Picking up on variables on definition

If possible pick up variables when they are defined using RegEx like:

`Dim\s+([a-zA-Z_~\x80-\xFF][0-9@&%$#!\x0C\x09a-zA-Z_~\x80-\xFF]*)\s+as\s+string`

Then

```
if \1 ~= "Add|Alter|Browse|Call|Close|Create|DDE|DDEExecute|DDEPoke|DDETerminate|DDETerminateAll|Declare|Delete|Dialog|Dim|Do|Drop|Else|ElseIf|End|Error|Event|Exit|Export|Fetch|Find|For|Function|Get|Global|Goto|Graph|If|Import|Insert|Layout|Map|Menu|Note|Objects|OnError|Open|Pack|Print|PrintWin|ProgressBar|Put|ReDim|Register|Reload|Remove|Rename|Resume|Rollback|Run|Save|Seek|Select|Set|Shade|StatusBar|Stop|Sub|Type|Update|While|UnDim" then CatchError
```
