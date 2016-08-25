Gui,Add,GroupBox,x20 y18 w360 h55,MapBasic Application
Gui,Add,DropDownList,x30 y40 w290,DropDownList
Gui,Add,Button,x330 y40 w40 h23,Edit
Gui,Add,GroupBox,x20 y79 w360 h45,Compile Method
Gui,Add,Checkbox,x90 y100 w70 h13,'::' Prefix
Gui,Add,Checkbox,x200 y100 w90 h13,Smart Compile
Gui,Add,GroupBox,x20 y131 w360 h69,Options
Gui,Add,Checkbox,x55 y152 w140 h13,'/* ... */' Block Comment
Gui,Add,Checkbox,x55 y172 w85 h13,Auto-Declare
Gui,Add,Button,x135 y210 w50 h23,Save
Gui,Add,Button,x215 y210 w50 h23,Cancel
Gui,Show,x386 y232 w402 h244 ,
Return
GuiClose:
ExitApp
Return