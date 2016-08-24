# MapBasic_Window_Extension
This is an Open Source project. We are developing a powerful extension for the MapBasic Window in Pitney Bowes' MapInfo. The extension will give users the ability to compile on demand from the MapBasic Window. Further extensions may include custom MapBasic functions to accomplish common tasks.

## Current Functionality:
1. Run scripts from MapBasic Window as usual. There are currently 2 different compile methods which have been implemented:
    
    i) Compile if Prefixed with "::"
    
    ```  
    ::
    For i = 1 to 10
        print i
    next i
    ```
    
    ii) Compile if required. Searches for keywords like `Sub` and `For ... next`. If found the program will compile it and run the compiled file in the (current?) instance of MapInfo.




## Planned features:
* [ ] Settings menu to manage features.
* [ ] Auto-Declare - No longer any need to declare subs and functions!
* [ ] Enter_Behaviour - Run selected line/selection or Run entire script
* [ ] MapBasic Project and Modular programming support (with auto .mbp generation).
* [ ] Better detection of MapBasic Window being active. (MapInfo makes it hard to do this, but should be possible)
* [ ] External MapBasic Window?
* [ ] Ability to use multiple compilation methods at once?


## Potential Features:
* [ ] Improting external transpiling libraries for use in Extended MapBasic.
* [ ] Object orientation support for MapBasic?
* [ ] MapInfo object definition/intiialisation/updating.
* [ ] COM Support for Extended MapBasic.
* [ ] Support for custom functions to return custom types.
