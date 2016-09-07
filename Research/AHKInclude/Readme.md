# AHK - Include AHK Scripts

This folder will contain a series of tests to show and, well test..., the functionality of AHKs #Include statment.

Include Syntax:

```
#Include "xyz.ahk"
```


#Test 1 - 3 Files

```
A.AHK: {
  #Include B.AHK
}
```

```
B.AHK {
  #Include C.AHK
}
```

```
C.AHK {
  msgbox, hello you!
}
```

#Result

When running A.AHK, msgbox appears with "hello you!", as expected.

#Test 2 - 3 Files

```
A.AHK: {
  msgbox, hello me!
  #Include B.AHK
  msgbox, hello all!
}
```

```
B.AHK {
  #Include C.AHK
}
```

```
C.AHK {
  msgbox, hello you!
}
```

#Results:
When running A.AHK > {
  msgbox appears with text "hello me!"
  msgbox appears with text "hello you!"
  msgbox appears with text "hello all!"
}

From this we can assume that in AHK, #Include ... essentially implies "execute code of ... and store its functions in memory"

This implies that we can create a header file: Header.AHK
We can include this header in our MAIN routine.
The header will then include all other scripts in the document.

It might also be nice to have a "transpile.ahk" which #Include's all .EMB transpiling scripts. However this would ensure all transpile options are enabled by default, which is something we may like to avoid.

#Test 3 - 3 Files

```
A.AHK: {
  #Include B.AHK
  msgbox, %abc%
}
```

```
B.AHK {
  #Include C.AHK
}
```

```
C.AHK {
  abc := "abcdefg, now I know my ABC"
}
```

#Results:

When running A.AHK > {
  msgbox appears with text "abcdefg, now I know my ABC"
}

This shows that variables declared in one child AHK file are continued through to the parent AHK file. I.E. All variables are global.

#Test 4
```
A.AHK{
	Msgbox, Loading B
	#Include B.AHK
	Msgbox, Loading C
	#Include C.AHK
	Msgbox, The modules %B% and %C% have been loaded loaded
}
```

```
B.AHK {
	B := "B"
}
```

```
C.AHK {
	C := "C"
}
```

#Results: 

Msgbox, Loading B

Msgbox, Loading C

Msgbox, The modules B and C have been loaded loaded

~~~END~~~

#Test 5

```
A.AHK{
	#Include B.AHK
	#Include C.AHK
	Msgbox, The modules %B% and %C% have been loaded.
}
```

```
B.AHK {
	B := "B"
	Return
	mysub:
	Return
}
```

```
C.AHK {
	C := "C"
}
```

#Results:

Msgbox, Loading B

~~~END~~~

## Why?

When the script runs into B and encounters 'return' execution of header script is halted.
