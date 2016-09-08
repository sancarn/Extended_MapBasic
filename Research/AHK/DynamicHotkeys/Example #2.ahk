#SingleInstance force
#NoEnv
SetBatchLines, -1

Loop,5 {
 Gui, Add, Text, xm, Enter Hotkey #%A_Index%:
 Gui, Add, Hotkey, x+5 vHK%A_Index% gLabel     ;add some hotkey controls
 Gui, Add, CheckBox, x+5 vCB%A_Index%, Win     ;add checkboxes to allow the Windows key (#) as a modifier.
}
Gui, Show,,Dynamic Hotkeys
return
GuiClose:
 ExitApp

Label:
 If %A_GuiControl% in +,^,!,+^,+!,^!,+^!     ;If the hotkey contains only modifiers, then return to wait for a key.
  return
 num := SubStr(A_GuiControl,3)               ;Get the number of the hotkey control.  
 If (savedHK%num%) {                         ;If a hotkey was already saved in this control...
  Hotkey,% savedHK%num%, Label%num%, Off     ;     turn the old hotkey off
  savedHK%num% .= " OFF"                     ;     add the word 'OFF' to display in a message.
 }
 If (%A_GuiControl% = "") {                  ;If the new hotkey is blank...
  TrayTip, Label%num%,% savedHK%num%, 5      ;     show a message: the old hotkey is OFF
  savedHK%num% =                             ;     save the hotkey (which is now blank) for future reference.
  return                                     ;This allows an old hotkey to be disabled without enabling a new one.
 }
 Gui, Submit, NoHide
 If CB%num%                                  ;If the 'Win' box is checked, then add its modifier (#).
  %A_GuiControl% := "#" %A_GuiControl%
 If StrLen(%A_GuiControl%) = 1               ;If the new hotkey is only 1 character, then add the (~) modifier.
  %A_GuiControl% := "~" %A_GuiControl%       ;     This prevents any key from being blocked.
 Hotkey,% %A_GuiControl%, Label%num%, On     ;Turn on the new hotkey.
 TrayTip, Label%num%
  ,% %A_GuiControl% " ON`n" savedHK%num%, 5  ;Show a message: the new hotkey is ON.
 savedHK%num% := %A_GuiControl%              ;Save the hotkey for future reference.
return

;These labels may contain any commands for their respective hotkeys to perform.
Label1:
 MsgBox,% A_ThisLabel "`n" A_ThisHotkey
return

Label2:
 MsgBox,% A_ThisLabel "`n" A_ThisHotkey
return

Label3:
 MsgBox,% A_ThisLabel "`n" A_ThisHotkey
return

Label4:
 MsgBox,% A_ThisLabel "`n" A_ThisHotkey
return

Label5:
 MsgBox,% A_ThisLabel "`n" A_ThisHotkey
return