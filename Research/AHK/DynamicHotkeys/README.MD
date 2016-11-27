SRC: https://autohotkey.com/board/topic/47439-user-defined-dynamic-hotkeys/

I spent some time searching the forums for a simple GUI allowing users to define their own hotkeys; but had a really hard time finding one. Since I couldn't find a good example relatively quickly, we can use one more. :) 

There are four code examples in this post. The first is very simple, while each subsequent example adds features and becomes progressively more complex. All of these examples do at least two things.[*:2v4habpk]Prompt the user for a hotkey.
[*:2v4habpk] Activate the hotkey immediately for a predefined subroutine in the same script.Note this caveat from the AHK documentation.

The Hotkey control has limited capabilities. For example, it does not support mouse/joystick hotkeys...
It also does not support custom combinations using &. The purpose here is to provide a demonstration of the control, rather than AHK's full hotkey capabilities. Since the advice is often given in the help forum, "Use a Hotkey control," here is an example of exactly how a person might do that.

EXAMPLE #1: Single Hotkey Control
This is the simplest example.

EXAMPLE #2: Multiple Hotkey Controls
This example makes extensive use of dynamic variables.

EXAMPLE #3: Optional Features
This example adds the following features to example #2.
- Hotkeys are automatically saved to an INI file.
- Duplicate hotkeys are prevented.

EXAMPLE #4: Special Keys
This example adds the following feature to example #3.
- Special keys which are normally restricted are allowed as hotkeys. This example requires AHK_L 38+.
- The newly allowed hotkeys are: AppsKey, BackSpace, Delete, Enter, Escape, Pause, PrintScreen, Space, Tab.
