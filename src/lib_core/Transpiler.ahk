Global Transpile_Params

ForEachPattern(mbsource,pattern,operationName){
  ;Match in the mbsource where matches pattern
  i := 1
  i := RegExMatch(mbsource, "iO)" . pattern, oMatch, i)

  ;Loop over all i
  while i <> 0 {
    %operationName%(mbsource,oMatch,Transpile_Params)

    ;Next i (Needed in the case where oMatch.Value(1) = "")
    i := oMatch.Pos(0) + oMatch.Len(0)  ;+1??? ;TODO

    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }

  return mbsource
}

Transpiler_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  out_String := SubStr(src, index, length)
  src := SubStr(src,1,index - 1) . SubStr(src,index + length)
  return out_String
}

Transpiler_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}

Class utils
{
  iqt(byref pattern)
  {
    ;iqt a.k.a. Ignore Quoted Text is a simple utility for ignoring some pattern contained in a written string.
    ;For example:
    ;The pattern :- debug\.print\s+(.+(?:\s*&.+)*)
    ;Will recognise:
      ;debug.print "hello world"
      ;debug.print a & "b" & c
    ;However we wouldn't want it to recognise:
      ;print "debug.print ""hello world"""
    ;To ignore this special case we use:
      ;pattern = """" . pattern . """|(" . pattern . ")"
    ;At this point the quoted text will be matched but the pattern we want to find will be captured. I.E.
      ;Match includes [print "debug.print ""hello world"""]
      ;Match1 does not include [print "debug.print ""hello world"""]
    pattern := """" . pattern . """|(" . pattern . ")"
    return pattern
  }
  insertMBOperators(byref s, toReplace){
      mboperators := "(?:\+|\*|-|=|\/|\\|\^|&|<>|<|<=|>|>=|AND|OR|NOT|MOD|CONTAINS|CONTAINS\s+PART|CONTAINS\s+ENTIRE|WITHIN|PARTLY\s+WITHIN|ENTIRELY\s+WITHIN|INTERSECTS)"
      s = strreplace(s,toReplace,mboperators)
      return s
  }
  insertDeclarationArgs(byref s, toReplace){
    mbDeclareArgs = (?:\s*\w+\s+as\s+\w+\s*){0,1}(?:,\s*\w+\s+as\s+\w+\s*)*
    s = strreplace(s,toReplace,mbDeclareArgs)
    return s
  }
  AppendDef(mbdef){

  }
  WriteDef(){
    FileAppend, %mbdef%, %A_WorkingDir%\ExtendedMapBasic.DEF
  }
}
