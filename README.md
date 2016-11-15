# Extended MapBasic

![Logo](/EMB_Head.png)

This is an Open Source project. We are developing a powerful extension for Pitney Bowes' MapBasic Language. The Extended MapBasic Language can be passed through this transpiler to turn it into native MapBasic code. From here it will be compiled into executable MBX files or an executable .exe file.

The Extended MapBasic Language will include features such as:

* Auto-Declare
* Block Commenting
* Optional parameters
* Array parameters for functions
* Auto MBP generation
* Inbuilt Extended MapBasic Window - to allow running and compilation of Extended MapBasic Projects on the fly.

For a detailed list of planned and potential future features, see the lists below.

Feel free to post ideas for features as issues. If you want to make additions to the source, feel free to send me a message and I'll set up the permissions.

## Current Functionality - A MapBasic Window Compilation:
1. Run scripts from MapBasic Window as usual or where required, compile MapBasic scripts and execute them in the (current?) instance of MapInfo.

This project is still very much Work In Progress (as you can see from the planned features list)

## Planned Compiler Features:
* [ ] Settings menu to manage features.
* [x] Block Commenting - Syntax: /* ... */
* [x] Block Strings - Syntax: (" ... ")
* [ ] Debug Mode <- If True, Debug.Print ... == Print ..., else Debug.Print ... == 'Print ...
* [ ] Sub/Function Trace - Sub() ... Print "\<ModuleName\>:\<subName/functionName\>"
* [ ] E_CurrentTable - Targetting the frontmost table, which is most useful in MBWindow.
* [ ] E_FreeFile - Gets a file number that isn't open by another process.
* [ ] Auto-Declare - No longer any need to declare subs and functions!
* [ ] Select from Query tables alongside existing tables: Select * from table1, query1 where...
* [ ] MapBasic Project and Modular programming support (with auto .mbp generation).
* [ ] Optional parameters for functions and sub-routines
* [ ] Arrays as parameters for functions
* [ ]   -- ByVal Arrays for functions and sub-routines.
* [ ] PreTranspile: { ... } AHK Code blocks -Perform AHK Script before transpiling mapbasic document.
* [ ] PreCompile: { ... } AHK Code blocks   -Perform AHK script before compiling mapbasic document.
* [ ] PostCompile: { ... } AHK Code blocks  -Perform AHK script after compiling mapbasic document.
* [ ] ".EMB" file format
* [ ] Compile to .exe

## Planned MBWindow support:
* [x] Enter_Behaviour - Run selected line/selection or Run entire script
* [x] Better detection of MapBasic Window being active. (MapInfo makes it hard to do this, but should be possible)
* [x] Ability to use multiple compilation methods at once? -- This seemed pointless since the RegEx method worked so well. Now we souly use that method to compile from the MBWindow.
* [ ] Custom MapBasic Window built in HTML with ACE including custom syntax highlighting, code snippits importing, code running...

## Potential Features:
* [ ] Importing external transpiling libraries for use in Extended MapBasic.
* [ ] Object orientation support for MapBasic?
* [ ] MapInfo object definition/intiialisation/updating.
* [ ] COM Support.
* [ ] WinAPI Wrapper.
* [ ] Dynamic functions (functions called from strings)
* [ ] Support for custom functions to return custom types.
* [ ] Visual Ribbon Editor.
