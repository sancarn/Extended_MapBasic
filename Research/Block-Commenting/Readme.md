Regex for finding block comments within code:

```
"(?:.|\s)*?\/\*(?:.|\s)*?\*\/(?:.|\s)*?"|(\/\*(?:.|\s)*?\*\/)
```

Note :- The regex above **captures** the comments which **ARE NOT** part of strings. I.E.

This is not captured but is matched: `"This comment /* hello */ is part of a string"`.

This is captured but is not matched: `/* This is a comment */`.

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
