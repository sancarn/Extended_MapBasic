#IfWinActive ahk_exe MapInfoPro.exe ;THIS WILL NEED EXTENSION THROUGH "isMapBasicWindow()"
$Enter::    ;$ so Enter can be re-used
    
    If Not isMapBasicWindow() {
        send, {Enter}
        return
    }
    
    ;Get the MapBasic source from the MapBasic Window
    old_clipboard := ClipboardAll
	Clipboard=
	send, ^c
	clipwait,0.1
	MBSource := clipboard
	clipboard := old_clipboard
	
	MBSource := preCompile(MBSource)
	
	If (MBSource <> "") {
	    Compile(MBSource)
	} else {
	    send,{Enter}
	}
return

isMapBasicWindow(){
    ;TO DO: This should have more (fast) checks.
    MapInfo = ComObjGet("MapInfo.Application.x64")
    return MapInfo.Eval("ActiveWindow()") = 1002
}

preCompile(src){
	If (LTrim(SubStr(src,1,2)) = "::") {
	    return LTrim(SubStr(src,3))
	} else {
	    ;Separated RegEx - This may require simplifying...:
		i := 0
		i := i + regexmatch(src,"i)\bAlter\b\s+\b(Control|MapInfoDialog)\b")		;matches {Alter Control,Alter MapInfoDialog}
		i := i + regexmatch(src,"i)\bCall\b")						            	;matches Call
		i := i + regexmatch(src,"i)\bDeclare\b\s+\b(Function|Sub)\b")				;matches {Declare Function, Declare Sub}
		i := i + regexmatch(src,"i)\bDefine\b")						            	;matches Define
		i := i + regexmatch(src,"i)\bDialog\b")						            	;matches {Dialog, Dialog Preserve, Dialog Remove}
		i := i + regexmatch(src,"i)\bDim\s+\w+\s*(,\s*\w+\s*)+\s+as\b")				;matches Dim {2 variable declarations} as
		i := i + regexmatch(src,"i)\bDo\s+Case\s+(.|\s)*?\bEnd\s+Case\b")			;matches Do Case … End Case,
		i := i + regexmatch(src,"i)\bDo\b\s+(.|\s)*?\bLoop\b")				    	;matches Do … Loop
		i := i + regexmatch(src,"i)\bEnd\s+Program\b")					         	;matches End Program
		i := i + regexmatch(src,"i)\bExit\s+(Do|For|Function|Sub)\b")				;matches {Exit Do, Exit For, Exit Function, Exit Sub}
		i := i + regexmatch(src,"i)\bFor\b(.|\s)*?\bNext\b")				    	;matches For … Next,
		i := i + regexmatch(src,"i)\bFunction\b(.|\s)*\bEnd\s+Function\b")			;matches Function … End Function
		i := i + regexmatch(src,"i)\bGoTo\b")			            				;matches GoTo
		i := i + regexmatch(src,"i)\bSub\b(.|\s)*\bEnd\s+Sub\b")				    ;matches Sub … End Sub
		i := i + regexmatch(src,"i)\bIf\b(.|\s)*?\bThen\b(.|\s)*?\bEnd\s+If\b")		;matches If .*? then … End If
		i := i + regexmatch(src,"i)\bInclude\b\s+\b"".*""\b")				    	;matches Include “…”
		i := i + regexmatch(src,"i)\bOnError\s+GoTo\b")					        	;matches OnError GoTo
		i := i + regexmatch(src,"i)\bOpen\s+File\b")					    	    ;matches Open File
		i := i + regexmatch(src,"i)\bProgressBar\b")    					    	;matches ProgressBar
		i := i + regexmatch(src,"i)\bResume\b")			    				        ;matches Resume
		i := i + regexmatch(src,"i)\bSet\s+Handler\b")		    				    ;matches Set Handler
		i := i + regexmatch(src,"i)\bType\b(.|\s)*?\bEnd\s+Type\b") 				;matches Type … End Type
		i := i + regexmatch(src,"i)\bWhile\b(.|\s)*?\bWend\b")		    			;matches While … Wend
		
		if (i>0) {
		    return src
		} else {
		    return ""
		}
	} 
}
