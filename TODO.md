## Planned Compiler Features:
* [ ] Settings menu to manage features.
* [x] Block Commenting - Syntax: /* ... */
* [x] Block Strings - Syntax: (" ... ")
* [ ] -- CrLf->\n Option.
* [ ] -- Parsing Function option.
* [x] Debug Mode <- If True, Debug.Print ... == Print ..., else Debug.Print ... == 'Print ....
* [ ]  -- Debug.Print ..., {iRGBColor} == (Print to HTML)
* [x] Sub/Function Trace - Sub() ... Print "\<ModuleName\>:\<subName/functionName\>"
* [x] Auto-Declare - No longer any need to declare subs and functions!
* [ ] MapBasic Project and Modular programming support (with auto .mbp generation).
* [ ] Implementation of Enums (For IDE - IntelliSence).
* [ ] Ability to add enums for existent functions e.g. AddEnum("tableinfo(winid,ENUM as TAB_INFO)")
* [ ] PreTranspile: { ... } AHK Code blocks -Perform AHK Script before transpiling mapbasic document.
* [ ] PreCompile: { ... } AHK Code blocks   -Perform AHK script before compiling mapbasic document.
* [ ] PostCompile: { ... } AHK Code blocks  -Perform AHK script after compiling mapbasic document.
* [ ] ".EMB" file format with auto-transpile.
* [ ] Compile to .exe
* [ ] Object orientation support for MapBasic.
* [ ]   -- Classes in Classes in Classes...
* [ ]   -- Overwriting and Extending existing Classes/Objects
* [ ]   -- Reference objects (*'Run code x each time y is updated'*)
* [ ]   -- MapInfo Application Objects
* [ ]   -- Utils class
* [ ]   -->> Utils.FF = E_FreeFile
* [ ]   -->> Utils.CT = E_CurTable
* [ ]   -->> Utils.CQ = E_CurQuery
* [ ]   -->> Utils.T(\d+) = tableinfo(\1,1)
* [ ] E_CurTable - Targetting the frontmost table, which is most useful in MBWindow.
* [ ] E_FreeFile - Gets a number that isn't open by another process.
* [ ] Select from Query tables alongside existing tables: Select * from table1, query1 where...
* [ ] Optional parameters for functions and sub-routines
* [ ] Arrays as parameters for functions
* [ ]   -- ByVal Arrays for functions and sub-routines.


## Planned MBWindow support:
* [x] Enter_Behaviour - Run selected line/selection or Run entire script
* [x] Better detection of MapBasic Window being active. (MapInfo makes it hard to do this, but should be possible)
* [x] Ability to use multiple compilation methods at once? -- This seemed pointless since the RegEx method worked so well. Now we souly use that method to compile from the MBWindow.
* [ ] Custom MapBasic Window built in HTML with ACE including custom syntax highlighting, code snippits importing, code running...
* [ ] ~ Iff(bool, cmd_true, cmd_false) command 


## Potential Features:
* [ ] Importing external transpiling libraries for use in Extended MapBasic.
* [ ] COM Support.
* [ ] WinAPI Wrapper.
* [ ] Dynamic functions (functions called from strings)
* [ ] Support for custom functions to return custom types.
* [ ] Visual Ribbon Editor.
