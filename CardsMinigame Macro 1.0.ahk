#NoEnv
#SingleInstance Force
#MaxThreadsPerHotkey 2
Thread, Interrupt, 1

if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

SendMode Event
SetBatchLines, -1
SetMouseDelay, -1
SetKeyDelay, -1, -1
CoordMode, Mouse, Client
CoordMode, Pixel, Client
SetTitleMatchMode, 2

global STOP := false
global PAUSED := false
global SelectorSubmitted := false
global lastF2 := 0
global SelectedCard := ""
global lastMode := ""

global CARD1_X := 545, CARD1_Y := 230
global CARD5_X := 545, CARD5_Y := 312
global CARD50_X := 546, CARD50_Y := 398
global CHECK_X := 429, CHECK_Y := 391
global CHECK_CLR := 0x2DDB11

Card1Clicks := [[269,238,0xFFFFFF],[403,230,0x909EA7],[534,233,0x0A2E3B],[400,372,0x64D123]]
Card5Clicks := [[248,222,0xEAAA04],[350,225,0x93A1A9],[450,223,0x957616],[400,372,0x64D123]]
Card50Clicks := [[231,219,0xEC314F],[307,221,0xFF304F],[392,221,0xFF304F],[400,372,0x64D123]]

F1::
if (SelectorSubmitted)
    return
STOP := false
PAUSED := false
Gosub, ShowModeSelector
return

F2::
debounceMs := 300
if (A_TickCount - lastF2 < debounceMs)
    return
lastF2 := A_TickCount
PAUSED := !PAUSED
ToolTip, % PAUSED ? "Paused" : "Running"
SetTimer, RemoveToolTip, -800
return

F3::
SelectorSubmitted := false
STOP := true
PAUSED := false
Sleep, 250
Gosub, ShowModeSelector
return

F4::
ExitApp

ShowModeSelector:
SelectorSubmitted := false
Gui, ModeSelect:Destroy
Gui, ModeSelect:New, +AlwaysOnTop +ToolWindow, Mysterious Card Game Macro

Gui, Font, s13 Bold, Segoe UI
Gui, Add, Text, x0 y15 w320 Center, Mysterious Card Game Macro

Gui, Font, s11, Segoe UI
Gui, Add, Text, x0 y60 w320 Center, Card Selection:

Gui, Font, s11, Segoe UI
Gui, Add, Button, x45 y100 w50 h35 gSelectCard1 vbtnC1, 1
Gui, Add, Button, x135 y100 w50 h35 gSelectCard5 vbtnC5, 5
Gui, Add, Button, x225 y100 w50 h35 gSelectCard50 vbtnC50, 50

Gui, Font, s7, Segoe UI
Gui, Add, Text, x0 y170 w320 Center, RCU Macro Made by (N0NG) Cinnamowopal

Gui, Show, w320 h200, Mysterious Card Macro

while !SelectorSubmitted
    Sleep, 50
return

SelectCard1:
    SelectedCard := "1"
    lastMode := "1"
    SelectorSubmitted := true
    Gui, ModeSelect:Hide
    LoopCard1()
return

SelectCard5:
    SelectedCard := "5"
    lastMode := "5"
    SelectorSubmitted := true
    Gui, ModeSelect:Hide
    LoopCard5()
return

SelectCard50:
    SelectedCard := "50"
    lastMode := "50"
    SelectorSubmitted := true
    Gui, ModeSelect:Hide
    LoopCard50()
return

ModeSelectGuiClose:
SelectorSubmitted := true
Gui, ModeSelect:Destroy
return

PauseIfCheckGreenButton() {
    global CHECK_X, CHECK_Y, CHECK_CLR, PAUSED
    PixelGetColor, res, %CHECK_X%, %CHECK_Y%, RGB
    if (res = CHECK_CLR)
    {
        MouseMove, %CHECK_X%, %CHECK_Y%, 0
        Click
        PAUSED := true
        ToolTip, Green button found. Paused.
        SetTimer, RemoveToolTip, -2000
        while PAUSED
            Sleep, 100
    }
}

LoopCard1() {
    global STOP, PAUSED, CARD1_X, CARD1_Y, Card1Clicks
    Loop {
        while (PAUSED)
            Sleep, 100
        if STOP
            return
        MouseMove, % CARD1_X + 2, % CARD1_Y + 2, 0
        Sleep, 70
        MouseMove, %CARD1_X%, %CARD1_Y%, 0
        Click
        PauseIfCheckGreenButton()
        Sleep, 200
        Loop, % Card1Clicks.Length()
        {
            bx := Card1Clicks[A_Index][1], by := Card1Clicks[A_Index][2]
            MouseMove, % bx + 2, % by + 2, 0
            Sleep, 70
            MouseMove, %bx%, %by%, 0
            Click
            if (A_Index = 3)
                Sleep, 3600   ; <-- After 3rd click, sleep is on this line
            else if (A_Index = 4)
                Sleep, 1000
            else
                Sleep, 100
        }
    }
}

LoopCard5() {
    global STOP, PAUSED, CARD5_X, CARD5_Y, Card5Clicks
    Loop {
        while (PAUSED)
            Sleep, 100
        if STOP
            return
        MouseMove, % CARD5_X + 2, % CARD5_Y + 2, 0
        Sleep, 70
        MouseMove, %CARD5_X%, %CARD5_Y%, 0
        Click
        PauseIfCheckGreenButton()
        Sleep, 200
        Loop, % Card5Clicks.Length()
        {
            bx := Card5Clicks[A_Index][1], by := Card5Clicks[A_Index][2]
            MouseMove, % bx + 2, % by + 2, 0
            Sleep, 70
            MouseMove, %bx%, %by%, 0
            Click
            if (A_Index = 3)
                Sleep, 4300   ; <-- After 3rd click, sleep is on this line
            else if (A_Index = 4)
                Sleep, 1000
            else
                Sleep, 100
        }
    }
}

LoopCard50() {
    global STOP, PAUSED, CARD50_X, CARD50_Y, Card50Clicks
    Loop {
        while (PAUSED)
            Sleep, 100
        if STOP
            return
        MouseMove, % CARD50_X + 2, % CARD50_Y + 2, 0
        Sleep, 70
        MouseMove, %CARD50_X%, %CARD50_Y%, 0
        Click
        PauseIfCheckGreenButton()
        Sleep, 200
        Loop, % Card50Clicks.Length()
        {
            bx := Card50Clicks[A_Index][1], by := Card50Clicks[A_Index][2]
            MouseMove, % bx + 2, % by + 2, 0
            Sleep, 70
            MouseMove, %bx%, %by%, 0
            Click
            if (A_Index = 3)
                Sleep, 5000   ; <-- After 3rd click, sleep is on this line
            else if (A_Index = 4)
                Sleep, 1000
            else
                Sleep, 100
        }
    }
}

RemoveToolTip:
ToolTip
return