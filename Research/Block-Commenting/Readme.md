Regex for finding block comments within code:

```
"(?:.|\s)*?\/\*(?:.|\s)*?\*\/(?:.|\s)*?"|(\/\*(?:.|\s)*?\*\/)
```

Note :- The regex above **captures** the comments which **ARE NOT** part of strings. I.E.

This is not captured but is matched: `"This comment /* hello */ is part of a string"`.

This is captured but is not matched: `/* This is a comment */`.


CAPTURED GROUPS WILL BE COMMENTED WITH USUAL MAPBASIC "'" NOTATION:

```
/* This
is
a
block
comment */
```

will transpile to:

```
'This
'is
'a
'block
'comment
```


The RegEx is still unable to find cases like:

```
/* 
This is the first part of the outercomment
/*
This is an inner comment. 
*/
This is the last part of the outer comment.
*/
```

However I believe this is quite common in programming languages and therefore could be classed as intended behaviour? - This is perhaps fixable with a different algorithm?

Furthermore this:

```
/* this is a
print "/* my life */"
```

Will not be picked up as a single line comment but a 2 line comment. This might cause problems. E.G.

```
/* this is the start of a comment
write #1, "hello there my /*padwan*/" & mbCrLf & 
          "Obiwan wishes to speak with you"
```

transpiles to

```
' this is the start of a comment
'write #1, "hello there my /*padwan*/" & mbCrLf & 
          "Obiwan wishes to speak with you"         <--- potential error?
```
