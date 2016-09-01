# Extended MapBasic

![Logo](/EMB_Head.png)

This is an Open Source project. We are developing a powerful extension for Pitney Bowes' MapBasic Language. The extension will include, new functionality such as Auto-Declare, Block Commenting, optional parameters, array parameters for functions, Auto MBP generation as well as an inbuilt MapBasic Window extension, allowing you to compile MapBasic code directly from the MapBasic Window. Further extensions may include custom MapBasic function libraries, custom statement creation, COM object support, WinAPI Objects and generalised object oriented programming.

Feel free to post ideas for features as issues. If you want to make additions to the source, feel free to send me a message and I'll set up the permissions. 

## Current Functionality - A MapBasic Window Compilation:
1. Run scripts from MapBasic Window as usual. There are currently 2 different compile methods which have been implemented:
    
    i) Compile if Prefixed with "::"
    
    ```  
    ::
    For i = 1 to 10
        print i
    next i
    ```
    
    ii) Compile if required. Searches for keywords like `Sub` and `For ... next`. If found the program will compile it and run the compiled file in the (current?) instance of MapInfo.


## Planned Compiler Features:
* [ ] Settings menu to manage features.
* [ ] Block Commenting "/* ... */"
* [ ] Auto-Declare - No longer any need to declare subs and functions!
* [ ] MapBasic Project and Modular programming support (with auto .mbp generation).
* [ ] Optional parameters for functions and sub-routines
* [ ] Arrays as parameters for functions
* [ ]   -- ByVal Arrays for functions and sub-routines.
* [ ] PreTranspile: { ... } AHK Code blocks -Perform AHK Script before transpiling mapbasic document.
* [ ] PreCompile: { ... } AHK Code blocks   -Perform AHK script before compiling mapbasic document.
* [ ] PostCompile: { ... } AHK Code blocks  -Perform AHK script after compiling mapbasic document.
* [ ] ".EMB" file format

## Planned MBWindow support:
* [ ] Enter_Behaviour - Run selected line/selection or Run entire script
* [ ] Better detection of MapBasic Window being active. (MapInfo makes it hard to do this, but should be possible)
* [ ] Ability to use multiple compilation methods at once?

## Potential Features:
* [ ] Importing external transpiling libraries for use in Extended MapBasic.
* [ ] Object orientation support for MapBasic?
* [ ] MapInfo object definition/intiialisation/updating.
* [ ] COM Support.
* [ ] WinAPI Wrapper.
* [ ] Dynamic functions (functions called from strings)
* [ ] Support for custom functions to return custom types.
* [ ] External MapBasic Window (this might end up being required. It'd be equivelent to an IDE)
* [ ] Visual Ribbon Editor.
