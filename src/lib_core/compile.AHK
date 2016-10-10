compile(MBSource, CompileDestination, MBCompilerLocation = "", runAfterCompile = 1 {
    ;MBSource = string containing mapbasic commands to compile
    ;CompileDestination = A file path designating the final path of the MBX
    ;The algorithm will be, create the file in %A_Temp%, then move the MBX when finished.
    
    ;Create new file for mapbasic code.
    FileDelete, %A_Temp%\MapBasicWindowCompile.mb    ;Delete compile destination if exists
    FileAppend, %MBSource%, %A_Temp%\MapBasicWindowCompile.mb
	
	;If MBCompilerLocation is not given, try to find it
	If (MBCompilerLocation = "") {
        MBCompilerLocation = _FindExecutable(CompileDestination))
    } else if (MBCompilerLocation = "") { ;If MBCompilerLocation is still blank
        Msgbox, 4112, Extended MapBasic Compiler, Cannot find MapBasic.exe, Check the Settings GUI to add it.
        return
    }
    
	;Debugging
	;msgbox,%comspec% /C "%MBCompilerLocation%" -server -D %A_Temp%\MapBasicWindowCompile.mb,,Hide
	
	;Compile into temporary
	runwait, %comspec% /C "%MBCompilerLocation%" -server -D %A_Temp%\MapBasicWindowCompile.mb,,Hide
    
    ;Move file to MBX to new location
    If FileExist(A_Temp "\MapBasicWindowCompile.MBX") {     ;if successfully compiled
        FileMove, A_Temp "\MapBasicWindowCompile.MBX", CompileDestination, 1
        If runAfterCompile {                                ;if script is desired to execute after running...
            runwait, %comspec% /C "%A_Temp%\MapBasicWindowCompile.MBX",,Hide
        } else {
            return
        }
    } else if FileExist(A_Temp "\MapBasicWindowCompile.ERR") {      ;if compiled with an error
		Fileread, ErrorText, %A_Temp%\MapBasicWindowCompile.Err
		Msgbox, 4144, Extended MapBasic Compiler, %ErrorText%
	} else {                                                        ;if compiled with unknown error...
		Msgbox, 4112, Extended MapBasic Compiler, An unknown error occurred while trying to compile the script. Flag this as an issue @ https://github.com/sancarn/Extended_MapBasic/issues/.
    }
    
    ;Cleanup temporary files
    FileDelete, %A_Temp%\MapBasicWindowCompile.mb
    FileDelete, %A_Temp%\MapBasicWindowCompile.MBX
    FileDelete, %A_Temp%\MapBasicWindowCompile.ERR
    WinActivate, ahk_exe MapInfoPro.exe
}
