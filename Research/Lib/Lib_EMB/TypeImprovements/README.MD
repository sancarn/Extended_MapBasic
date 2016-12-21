# Custom Type Improvements

## Problems with MapBasic

1. Custom typed variables cannot be set in groups. Instead each element has to be set individually.
2. Custom Types cannot be returned from a function.


### Problem 1

E.G. The below code will not work in MapBasic, however it will work in other BASIC languages:

```
'Create a simple type
Type MyType
  pt1 as string
  pt2 as string
End Type

Dim a,b as MyType

'Initialise a
a.pt1 = "hello"
a.pt2 = "world"

'Set b to a
b = a

'Prove b == a
print b.pt1 & " " & b.pt2
```

**Working alternative #1**

```
'Create a simple type
Type MyType
  pt1 as string
  pt2 as string
End Type

Dim a,b as MyType

'Initialise a
a.pt1 = "hello"
a.pt2 = "world"

'Set b to a
b.pt1 = a.pt1
b.pt2 = a.pt2

'Prove b == a
print b.pt1 & " " & b.pt2
```

**Working alternative #2**
This alternative may save space in the long run:

```
'Create a simple type
Type MyType
  pt1 as string
  pt2 as string
End Type

Dim a,b as MyType

'Initialise a
a.pt1 = "hello"
a.pt2 = "world"

'Set b to a
Call MyType_Copy(b,a)

'Prove b == a
print b.pt1 & " " & b.pt2

Sub MyType_Copy(a as MyType,b as MyType)
  'Set A = B
  a.pt1 = b.pt1
  a.pt2 = b.pt2
End Sub
```

In both examples we need to detect when 2 variables of the  **SAME CUSTOM TYPE**  are equated, and then transpile the code to a function.

#### Methods

```{AHK}
;Define Scopes and Types arrays
Scopes := {}
Types := {}

;Set Scopes array. A scope is defined as the contents of a function or sub-routine or global
Scopes := ScopesGet()

For each Scope in Scopes
  ;Get variables from current scope
  Variables := GetScopeVariables(Scope)

  ;Get all custom variables
  For each Variable in Variables
    if (Variable.Type='Custom'){
      CustomVars.push Variable
    }
  Next Variable

  ;Look for variables that are equated to other variables in our custom set
  ;sVarSearch := utils.sJoin(CustomVars,"|")

  ;Get all equations from Scope
  Equations := GetScopeEquations(Scope)

  ;An Equation is made of 3 properties
  ;Equation.Expression  ;described below
  ;Equation.Result      
  ;Equation.Operator
  ;Result = <expression> <-- Equation
  ;Expressions DO NOT exist as arguments in functions, sub-routines, while conditions, if conditions, ...?

  ;Expressions also exist when:
  ;Case of Sub/Function Parameter
  ;While argument
  ;If argument
  ;It is possible for an expression to be a single value, in which case the equation is taken as a variable setting equation.

  ;Loop over all equations
  For each Equation In Equations
    eqVariables := GetEquationVariables(Equation)
    Comparison  := CompareObjects(eqVariable, CustomVars)
  Next Equation



  results := scope.search(sRegex, variables)


  ;Search for Pattern equalities
  sRegex := sVarSearch . "\s+=\s+" . sVarSearch

  ;
  results := scope.search(sRegex, variables)



Next Scope
```


```
;Detect direct equality
Regex: (\w+)\s+\=\s+(\w+)

;Find custom types:
Regex: Type\s+(\w+)

Scope has to be limited for functions and sub-routines.
```



### Problem 2

E.G. The below code will not work in MapBasic, however it will work in other BASIC languages:

```
'Create a simple type
Type MyType
  pt1 as string
  pt2 as string
End Type

Dim a as MyType

'Initialise a
a = f()

'Prove a = f()
print a.pt1 & " " & a.pt2

'**ERROR - INVALID RETURN TYPE**
Function f() as MyType
  f.pt1="hello"
  f.pt2="world"
End Function
```

**Working alternative**

The alternative is to use Sub-Routines instead of functions. Sub-Routines can take Custom Types >ByReference<. This is essentially like returning a variable value. The only issue here is we can't take variables 'ByVal'...

```
'Create a simple type
Type MyType
  pt1 as string
  pt2 as string
End Type

Dim a as MyType

'Initialise a
Call f(a)

'Prove a = f()
print a.pt1 & " " & a.pt2


Sub f(var_f as MyType)
  var_f.pt1="hello"
  var_f.pt2="world"
End Sub
```

### The ByVal Problem

The only issue here is we can't take variables 'ByVal'... Or can we? Taking a variable by value is actually relatively simple. "A variable taken By Value will not override the original variable". I.E.

`c = f(ByVal a) 'as MyType`

Is the same as...

```
Dim b as MyType
b = a
Call f(b)
c = b
```

Note how the value of a has not changed. a still contains the same values as it had when it started, however we have used a special temporary variable to pass that data onto c.

The above can be simplified to...

```
c = a
Call f(c)
```

However, not using a temporary variable may cause troubles further down the line?
