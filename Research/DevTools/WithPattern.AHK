;GUI make regex operations easier. Extracted pattern must be in a capturing group.

FunkyPrefix := "EMB_Lib"
FunkyName := "Tracer"
FunkyPattern = ".*?sub\s+.+?\(.*?"|".*?function\s+.+?\(.*?"|End\s+Sub|End\s+Function|Declare\s+Sub|Declare\s+Function|(sub\s+.+?\((?:.|\s)*?\))|(function\s+.+?\((?:.|\s)*?\)\s+as\s+\w+)

MainName := FunkyPrefix . "_" . FunkyName
PrivatePres := "p_" . FunkyPrefix . "_" . FunkyName

;MAKE CODE
;$1 = Name of function
;$2 = Pattern to find
;$3 = Prefix of private functions e.g. p_Lib_EMB_WithPattern

snippit =
(
$1(mbcode){
  ;Pattern explanation:


  ;*************************************************************************************************************************
  pattern = $2
  ;*************************************************************************************************************************

  ;Match in the mbsource where matches pattern
  i := RegExMatch(mbsource, "iO)" . pattern, oMatch, i)

  ;Loop over all i
  while i <> 0 {
    If oMatch.Value(1) {
      ;replace captured block comment with single line comments
      subSrc := $3_removeFromString(mbsource,oMatch.Pos(0), oMatch.Len(0))
        subSrc := $3_sHandleSubSrc(subSrc)
      $3_insertIntoString(mbsource,subSrc,oMatch.Pos(0))
    }

    ;Next i (Needed in the case where oMatch.Value(1) = "")
    i := oMatch.Pos(0) + oMatch.Len(0)

    ;Get next match from mbsource
    i := regexmatch(mbsource, "iO)" pattern, oMatch, i)
  }

  return mbsource
}

$3_removeFromString(ByRef src,index,length){
  ;Supply function with an index and length of a string to extract
  ;The function will extract and return the string and remove it from the original src string.
  out_String := SubStr(src, index, length)
  src := SubStr(src,1,index - 1) . SubStr(src,index + length)
  return out_String
}

$3_insertIntoString(ByRef src,in_String,index){
  ;inserts a string "in_String" into src before the index supplied.
  ;Mid(s,1,Index-1) & "---" & Mid(s,Index)
  src := SubStr(src,1,index-1) . in_String . SubStr(src,index)
  return
}

$3_sHandleSubSrc(subSrc){

}

)

TestVar := snippit
TestVar := StrReplace(TestVar,"$1",MainName)
TestVar := StrReplace(TestVar,"$2",FunkyPattern)
TestVar := StrReplace(TestVar,"$3",PrivatePres)
Clipboard := TestVar
