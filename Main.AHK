ProgramStart:
	#Persistant
	#SingleInstance
	
	Menu, tray, Tip, Compile in MapBasic Window`nAn application to allow compilation of MapBasic code in the MapBasic Window. Right-click to access the settings, to quit or to pause the application.
	Menu, tray, add, Settings
	Menu, tray, add ;separator
	;Menu, tray, add, Pause			;currently not implemented.
	Menu, tray, add, Exit
	
	
	;Compile methods:
	;1 - Compile on ::
	;2 - Compile when needs compiling (RegEx)
	;3 - Compile on ^+{Enter}
	
	;default compilation method = 2
	compileMethod := 2
return


/***********************************************************************************************************************************************************
							 FIND EXECUTABLE (to find MapBasic.exe)
***********************************************************************************************************************************************************/
#IfWinActive ahk_exe MapInfoPro.exe
Enter::
	old_clipboard := ClipboardAll
	Clipboard=
	
	send, ^c
	clipwait,0.1
	
	if needsCompiling(clipboard) {
		sSourceCode := prepareCompile(clipboard)
		FileAppend, %sSourceCode%, %A_Temp%\MapBasicWindowCompile.mb
		
		;Get default application to run .mb, and compile with this program:
		MapBasic_Path := _FindExecutable(A_Temp . "\MapBasicWindowCompile.mb")
		
		;msgbox,%comspec% /C "%MapBasic_Path%" -server -D %A_Temp%\MapBasicWindowCompile.mb
		
		runwait, %comspec% /C "%MapBasic_Path%" -server -D %A_Temp%\MapBasicWindowCompile.mb,,Hide
		runwait, %comspec% /C "%A_Temp%\MapBasicWindowCompile.MBX",,Hide
		FileDelete, %A_Temp%\MapBasicWindowCompile.mb
		WinActivate, ahk_exe MapInfoPro.exe
		
	} else {
		suspend, on
		send, {Enter}
		suspend, off
	}
	
	Clipboard := old_clipboard
return


;***************
 #IfWinActive ;*
;***************


/***********************************************************************************************************************************************************
							 FIND EXECUTABLE (to find MapBasic.exe)
***********************************************************************************************************************************************************/
;return the exe that would open "file" via association
;returns "" on failure and sets ErrorLevel to system error
;or function result, non-empty exe path on success
_FindExecutable(file)
{
  ;MAX_PATH is only 256 so leave a bit more room for unicode chars
  maxpath := 2048 * 2
  exepath := ""
  VarSetCapacity(exepath,maxpath)
  result := DllCall("Shell32\FindExecutable",str,file,str,0,str,exepath,Ptr)
  if (ErrorLevel)
    ErrorLevel := A_LastError
  else if (result < 33)
    ErrorLevel := result
  return exepath
}

/***********************************************************************************************************************************************************
							COMPILATION SPECIFIC FUNCTIONS AND SUBS
***********************************************************************************************************************************************************/

prepareCompile(src){
	Global compileMethod
	if (compileMethod = 1){
		return substring(src,3)
	} else if (compileMethod = 2) {
		return src
	} 
}

needsCompiling(src){
	Global compileMethod
	
	If (compileMethod = 1) {
		If (SubStr(clipboard[1,2)) = "::"
			return 1
		} else {
			return 0
		}
	} else if (compileMethod = 2) {
		;Separated RegEx:
		i := i + regexmatch(str,"i)\bAlter\b\s+\b(Control|MapInfoDialog)\b")			;matches {Alter Control,Alter MapInfoDialog}
		i := i + regexmatch(str,"i)\bCall\b")							;matches Call
		i := i + regexmatch(str,"i)\bDeclare\b\s+\b(Function|Sub)\b")				;matches {Declare Function, Declare Sub}
		i := i + regexmatch(str,"i)\bDefine\b")							;matches Define
		i := i + regexmatch(str,"i)\bDialog\b")							;matches {Dialog, Dialog Preserve, Dialog Remove}
		i := i + regexmatch(str,"i)\bDim\s+\w+\s*(,\s*\w+\s*)+\s+as\b")				;matches Dim {2 variable declarations} as
		i := i + regexmatch(str,"i)\bDo\s+Case\s+(.|\s)*\bEnd\s+Case\b")			;matches Do Case … End Case,
		i := i + regexmatch(str,"i)\bDo\b\s+(.|\s)*\bLoop\b")					;matches Do … Loop
		i := i + regexmatch(str,"i)\bEnd\s+Program\b")						;matches End Program
		i := i + regexmatch(str,"i)\bExit\s+(Do|For|Function|Sub)\b")				;matches {Exit Do, Exit For, Exit Function, Exit Sub}
		i := i + regexmatch(str,"i)\bFor\b(.|\s)*\bNext\b")					;matches For … Next,
		i := i + regexmatch(str,"i)\bFunction\b(.|\s)*\bEnd\s+Function\b")			;matches Function … End Function
		i := i + regexmatch(str,"i)\bSub\b(.|\s)*\bEnd\s+Sub\b")				;matches Sub … End Sub
		i := i + regexmatch(str,"i)\bGoTo\b")							;matches GoTo
		i := i + regexmatch(str,"i)\bIf\b(.|\s)*\bThen\b(.|\s)*\bEnd\s+If\b")			;matches If .*? then … End If
		i := i + regexmatch(str,"i)\bInclude\b\s+\b"".*""\b")					;matches Include “…”
		i := i + regexmatch(str,"i)\bOnError\s+GoTo\b")						;matches OnError GoTo
		i := i + regexmatch(str,"i)\bOpen\s+File\b")						;matches Open File
		i := i + regexmatch(str,"i)\bProgressBar\b")						;matches ProgressBar
		i := i + regexmatch(str,"i)\bResume\b")							;matches Resume
		i := i + regexmatch(str,"i)\bSet\s+Handler\b")						;matches Set Handler
		i := i + regexmatch(str,"i)\bType\b(.|\s)*\bEnd\s+Type\b")				;matches Type … End Type
		i := i + regexmatch(str,"i)\bWhile\b(.|\s)*\bWend\b")					;matches While … Wend
		return i>0
	}	
}		

/***********************************************************************************************************************************************************
								      Exit and Settings
***********************************************************************************************************************************************************/
OnExit:
	;Delete compiled RegEx, as it is no longer required.
	FileDelete, %A_Temp%\MapBasicWindowCompile.MBX
return

Settings:
	;Open GUI
	;DDL containing 3 compilation options.
	;Addition of compilation version and ability to select different MapBasic.exe
	;Save these in a file to disk.
return

/***********************************************************************************************************************************************************
							DETECTING COMPILATION REQUIREMENT WITH REGEX
/***********************************************************************************************************************************************************

Combined Regex:
i)(\bAlter\b\s+\b(Control|MapInfoDialog)\b|\bCall\b|\bDeclare\b\s+\b(Function|Sub)\b|\bDefine\b|\bDialog\b|\bDim\s+\w+\s*(,\s*\w+\s*)+\s+as\b|\bDo\s+Case\s+(.|\s)*\bEnd\s+Case\b|\bDo\b\s+(.|\s)*\bLoop\b|\bEnd\s+Program\b|\bExit\s+(Do|For|Function|Sub)\b|\bFor\b(.|\s)*\bNext\b|\bFunction\b(.|\s)*\bEnd\s+Function\b|\bSub\b(.|\s)*\bEnd\s+Sub\b|\bGoTo\b|\bIf\b(.|\s)*\bThen\b(.|\s)*\bEnd\s+If\b|\bInclude\b\s+\b"".*""\b|\bOnError\s+GoTo\b|\bOpen\s+File\b|\bProgressBar\b|\bResume\b|\bSet\s+Handler\b|\bType\b(.|\s)*\bEnd\s+Type\b|\bWhile\b(.|\s)*\bWend\b)

Separated Regex:
i := i + regexmatch(str,"i)\bAlter\b\s+\b(Control|MapInfoDialog)\b")			;matches {Alter Control,Alter MapInfoDialog}
i := i + regexmatch(str,"i)\bCall\b")							;matches Call
i := i + regexmatch(str,"i)\bDeclare\b\s+\b(Function|Sub)\b")				;matches {Declare Function, Declare Sub}
i := i + regexmatch(str,"i)\bDefine\b")							;matches Define
i := i + regexmatch(str,"i)\bDialog\b")							;matches {Dialog, Dialog Preserve, Dialog Remove}
i := i + regexmatch(str,"i)\bDim\s+\w+\s*(,\s*\w+\s*)+\s+as\b")				;matches Dim {2 variable declarations} as
i := i + regexmatch(str,"i)\bDo\s+Case\s+(.|\s)*\bEnd\s+Case\b")			;matches Do Case … End Case,
i := i + regexmatch(str,"i)\bDo\b\s+(.|\s)*\bLoop\b")					;matches Do … Loop
i := i + regexmatch(str,"i)\bEnd\s+Program\b")						;matches End Program
i := i + regexmatch(str,"i)\bExit\s+(Do|For|Function|Sub)\b")				;matches {Exit Do, Exit For, Exit Function, Exit Sub}
i := i + regexmatch(str,"i)\bFor\b(.|\s)*\bNext\b")					;matches For … Next,
i := i + regexmatch(str,"i)\bFunction\b(.|\s)*\bEnd\s+Function\b")			;matches Function … End Function
i := i + regexmatch(str,"i)\bSub\b(.|\s)*\bEnd\s+Sub\b")				;matches Sub … End Sub
i := i + regexmatch(str,"i)\bGoTo\b")							;matches GoTo
i := i + regexmatch(str,"i)\bIf\b(.|\s)*\bThen\b(.|\s)*\bEnd\s+If\b")			;matches If .*? then … End If
i := i + regexmatch(str,"i)\bInclude\b\s+\b"".*""\b")					;matches Include “…”
i := i + regexmatch(str,"i)\bOnError\s+GoTo\b")						;matches OnError GoTo
i := i + regexmatch(str,"i)\bOpen\s+File\b")						;matches Open File
i := i + regexmatch(str,"i)\bProgressBar\b")						;matches ProgressBar
i := i + regexmatch(str,"i)\bResume\b")							;matches Resume
i := i + regexmatch(str,"i)\bSet\s+Handler\b")						;matches Set Handler
i := i + regexmatch(str,"i)\bType\b(.|\s)*\bEnd\s+Type\b")				;matches Type … End Type
i := i + regexmatch(str,"i)\bWhile\b(.|\s)*\bWend\b")					;matches While … Wend


Other Regex Info:
i)					implies case insensitivity
\b					implies “word boundary”. I.E. \bcat\b will only match with cat and not seacat
(a|b|c)					matches a or b or c

To convert this list to full RegEx string, perform the following RegEx replace:
Replace "i := i + 1 + regexmatch(str,""" with ""
Replace "\s+matches.*\s+" with "|"

Then if the string remaining is <str> {Lang: VB}
str = "i)(" & left(str,len(str)-1) & ")"
***********************************************************************************************************************************************************/

