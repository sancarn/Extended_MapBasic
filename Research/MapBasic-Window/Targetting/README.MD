I was hoping we would be able to grab the hWND from MapInfo using the WindowInfo() function.
The MapInfo window ID for the MapBasic window is 1002.

If I do the following:
print WindowInfo(1002,12) '[or WindowInfo(WIN_MAPBASIC,WIN_INFO_WND) ]

I get 0 in the Message Window, regardless of whether the window is bound to MapInfo or not.

Unfortunately also there is no specific info that we can target from AHK that would indicate the current window being the MapBasic Window. However there is the active window's text which we can get with WinGetText statement. That contains this:

```
<<
>>
 List 
```

If the MapBasic window is not docked to the main application however the title of the window is indicated as "MapBasic". Therefore we can say:

```
WinGetTitle, TITLE, A
MapBasicWindowActive(){
    If winexist("MapBasic"){
        return TITLE = "MapBasic"
    } else {
        ;...
    }
}
```

The question really comes down to what we do in that ...

-----------------------------------------------------------------------------------------------

On a more positive note the Message window is much easier to access:
When docked:
> ClassNN: RICHEDIT1
> WindowInfo(1003,12) returns 1117068 (at least it returns something!)
> again if not docked wintitle = "Message"

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

Just talked to PBS about this problem. The MapBasic function

```
print ActiveWindow() = 1002
```

Prints true if the MapBasic window is active and false if the MapBasic window is not active.

After another discussion with PBS Support, I found that you can use COM's Eval() function to evaluate the ActiveWindow MapBasic function, from other applications.

E.G.

```
Dim activewin as Integer
activewin = MI.Eval("ActiveWindow()")
```

But how do we get the MapInfo COM object? (thanks to Peter Moller for this: https://groups.google.com/forum/#!topic/mapinfo-l/uipvypf6Ato)

```
Dim MapInfo as Object
Set MapInfo = GetObject(, "MapInfo.Application.x64")
```

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

Full code for detecting if the front window is the MapBasic Window (in VBA)

```
Function MapBasicActive() as Boolean
 Dim MapInfo as Object
 Set MapInfo = GetObject(,"MapInfo.Application.x64")
 MapBasicActive = MapInfo.Eval("ActiveWindow()") = 1002
End Function
