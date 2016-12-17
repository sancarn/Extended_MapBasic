# Individual Compilations

## With contents of class

```
Regex: Class\s+(\w+)(?:\s|.)*?\R(?:\s|.)*?End\s+Class
ThisClass_Name := \1
```

Alternative:
```
(?:Class\s+(\w+)|End\s+Class)
```

### Methods (Functions)
```
Regex: Function\s+(\w+)\(utils.params\)utils.*?End\s+Sub
```
Redefine as own Function with name:
```
%ThisClass_Name%_\1
```

### Methods (Sub Routines)

```
Regex: Sub\s+(\w+)\(utils.params\)utils.*?End\s+Sub
```

Redefine as own Function with name:

```
%ThisClass_Name%_\1
```

### New() Method

Add the New() Method so classes can be created.

### ThisGet() Method

Add the ThisGet() method so created objects can be distributed by distributing their GUID.

### Type addition.

Create a type definition or the class


```
Type MyClass_Type
  parentID as string
  childrenIDs(1) as string
  methods() as string
  clsName as string
  GUID as string

  <standard property types>
End Type
```

### NewGUID() - Create if function doesn't already exist.
