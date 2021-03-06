#SingleInstance force
#NoEnv

#Include %A_ScriptDir%\..\class_GuiControlTips.ahk

TipTxt := {}
TipTxt[0] := "Button control's`r`nmultiline Tooltip!"
TipTxt[1] := "Button's alternate Tooltip, might be as long as you want and is displayed in only one single line!"
ButtonTip := 0
; Create the GUI
Gui, New, hwndHGUI
Gui, Margin, 20, 20
; Style 0x100 (SS_NOTIFY) is needed if no gLabel is given
Gui, Add, Text, w400 h20 0x200 0x100 Border hwndHText, % " Some text here ..."
Gui, Add, Edit, w400 h200 hwndHEdit, Edit
Gui, Add, DDL, w400 h200 hwndHDDL, Choose 1||Choose 2|Cjoose 3|Choose 4|Choose 5
Gui, Add, Button, hwndHButton gChange w180, Tooltip will toggle on click!
Gui, Add, Button, vSuspend gSuspend x240 yp wp, Suspend On
; Create a ToolTip control
TT := New GuiControlTips(HGUI)
; Set initial delay to 1 second (1000 ms) and the pop-up duration to 2 seconds
TT.SetDelayTimes(1000, 2000, -1)
; Attach the controls
TT.Attach(HText, "Text control's centered Tooltip!", True)
TT.Attach(HEdit, "Edit control's Tooltip!")
TT.Attach(HDDL, "DDL control's Tooltip!")
TT.Attach(HButton, TipTxt[ButtonTip])
; Now show the GUI
Gui, Show, , Control Tips
Return
; ----------------------------------------------------------------------------------------------------------------------
GuiClose:
ExitApp
; ----------------------------------------------------------------------------------------------------------------------
Change:
   ButtonTip ^= 1
   TT.Update(HButton, TipTxt[ButtonTip])
Return
; ----------------------------------------------------------------------------------------------------------------------
Suspend:
   GuiControlGet, Mode, , %A_GuiControl%
   TT.Suspend(Mode = "Suspend On" ? True : False)
   GuiControl, , %A_GuiControl%, % "Suspend " . (Mode = "Suspend On" ? "Off" : "On")
Return



















