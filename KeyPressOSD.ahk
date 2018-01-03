; KeypressOSD.ahk
;--------------------------------------------------------------------------------------------------------------------------
;
; AVAILABLE SHORTCUTS:
; Ctrl+Alt+Shift+F8  - toggles "Show single key" option. Useful when you must reliably use dead keys.
; Ctrl+Alt+Shift+F9  - toggles between two OSD offsets: GuiYa and GuiYb
; Ctrl+Alt+Shift+F12 - Reinitialize OSD. Useful when it no longer appears on top. To have it appear on top of elevated apps, run it in administrator mode.
;
; FEATURES:
; - Show previously pressed key if fired quickly
; - Count key presses or key fires and mouse clicks
; - Automatic resizing of OSD/HUD or fixed size
; - Hides automatically when mouse runs over it
; - Generate beeps for key presses, modifiers, mouse clicks or just when typing with Capslock
; - Indicators for CapsLock, NumLock and ScrollLock states
; - Typing mode; shows what you are typing in an expanding text area
; - Dead keys support (partial), option to turn it off
; - Easy to configure with many options:
;   - to toggle features: key beepers, key counting or previous key
;   - to hide modifiers, mouse clicks or single key presses (which disables typing mode)
;   - or hide keys that usually get in the way: Left Click and Print Screen [HideAnnoyingKeys]
;   - differ between left and right modifiers
;   - OSD/HUD position, size and display time
;   - beep key presses even if keys are not displayed
;
; CHANGELOG:
; by Marius Sucan (robodesign.ro)
;             v2.73 (2017-10-05) - improvements for automatic resize calculation
;             v2.72 (2017-10-04) - new option: make beeps on mouse clicks
;                                - new option: dstinct beeper for modifier keys: Shift, Ctrl, Alt, WinKey.
;                                - new option: beep hidden keys; if you want it to beep even if the keys are not displayed
;                                - fix: now it always counts mouse clicks
;             v2.70 (2017-10-03) - added option to toggle dead keys support / work-around.
;                                - added option to hide annoying keys that usually get in the way: Left Click and Print Screen.
;                                - redraw improvements, reduced flickering
;                                - disabled OSD transparency to reduce flickering
;             v2.69 (2017-09-30) - OSD / GUI hides when mouse is over it. Many thanks to phaleth!
;             v2.68 (2017-09-29) - numpad keys now work in typing mode as expected; they appear as symbols or numbers
;
; by phaleth from irc.freenode.net #ahk
;             v2.67 (2017-09-28) - dead keys improvements
;
; by Marius Sucan (robodesign.ro)
;             v2.66 (2017-09-28) - key combinations with Shift work better.
;             v2.65 (2017-09-27) - Fixed a bug with counting modifier keys;
;                                - improved the dead keys work-around
;                                - friendly names for mouse clicks
;                                - when pressed, volume keys  always generate beeps
;                                - added option to differentiate between left and right modifiers
;                                - now it detects AltGr key
;                                - the key beeper now also makes a beep for modifiers.
;                                - capslock no longer erases text you are typing displayed by the OSD
;                                - now you can toggle between two different OSD positions with Ctrl + Alt + Shift + F9
;             v2.60 (2017-09-26) - Fixed many bugs with counting keys;
;                                - reimplemented the feature to see the previous key combination, if quickly a new one is pressed;
;                                - added options/settings to toggle previous keys, counting keys and delay;
;                                - added shortcuts to toggle ShowSingleKey option and to reinitialize the OSD;
;                                - added option for automatic resizing of the OSD; it can be turned off in the settings section; it is a fishy implementation, but if one adjusts it, can make it to suit personal needs;
;                                - new option: beep when key is released or when writing with capslock
;             v2.58 (2017-09-23) - Numpad keys have friendly naming, based on the numlock state.
;                                - Combinations with space and backspace work again.
;             v2.56 (2017-09-22) - more fixes for space usage and key combinations;
;                                - now it indicates when ScrollLock, NumLock and Capslock are activated.
;             v2.55 (2017-09-21) - minor fixes for space usage and key combinations.
;
; by Saiapatsu from irc.freenode.net #ahk
;             v2.54 (2017-09-21) - Scrolls through n recently typed characters instead of just the latest word
;             v2.53 (2017-09-21) - Case change effect limited to the loop 95 letters only.
;             v2.52 (2017-09-21) - Now supports backspace. Commented out CapsLock beeper.
;             v2.51 (2017-09-21) - Changed labels to functions, added ToolWindow style to window, changed DisplayTime
;                                  calculation, made it show last word typed, hid spacebar presses
;             todo: make Shift look less ugly
;
; by Marius Sucan (robodesign.ro)
;             v2.50 (2017-09-20) - Changed the OSD positioning and sizing. It was based on the current window. Now it is always fixed in a specific place. Added a Capslock beeper.
;
; by tmplinshi from https://autohotkey.com/boards/viewtopic.php?f=6&t=225
;             v2.22 (2017-02-25) - Now pressing same combination keys continuously more than 2 times,
;                                  for example press Ctrl+V 3 times, will displayed as "Ctrl + v (3)"
;             v2.21 (2017-02-24) - Fixed LWin/RWin not poping up start menu
;             v2.20 (2017-02-24) - Added displaying continuous-pressed combination keys.
;                                  e.g.: With CTRL key held down, pressing K and U continuously will shown as "Ctrl + k, u"
;             v2.10 (2017-01-22) - Added ShowStickyModKeyCount option
;             v2.09 (2017-01-22) - Added ShowModifierKeyCount option
;             v2.08 (2017-01-19) - Fixed a bug
;             v2.07 (2017-01-19) - Added ShowSingleModifierKey option (default is True)
;             v2.06 (2016-11-23) - Added more keys. Thanks to SashaChernykh.
;             v2.05 (2016-10-01) - Fixed not detecting "Ctrl + ScrollLock/NumLock/Pause". Thanks to lexikos.
;             v2.04 (2016-10-01) - Added NumpadDot and AppsKey
;             v2.03 (2016-09-17) - Added displaying "Double-Click" of the left mouse button.
;             v2.02 (2016-09-16) - Added displaying mouse button, and 3 settings (ShowMouseButton, FontSize, GuiHeight)
;             v2.01 (2016-09-11) - Display non english keyboard layout characters when combine with modifer keys.
;             v2.00 (2016-09-01) - Removed the "Fade out" effect because of its buggy.
;                                - Added support for non english keyboard layout.
;                                - Added GuiPosition setting.
;             v1.00 (2013-10-11) - First release by tmplinshi based on RaptorX. Function keys, numpad keys and mouse clicks support. Popups at mouse position.
;             v0.50 (2010-03-18) - Released by RaptorX.
;--------------------------------------------------------------------------------------------------------------------------
;
; TO-DO:::::::::::::::::::::::::::::::::::
; features to implement:
; - support for non-english keyboards [if started with English layout, and then change to your desired language layout, it works]
; - when user types single letters, display Shift + (sign or numeric keys) as signs/symbols, eg. Shift + 0, should be displayed as );
; - after pressing Shift + [letter] if the following key is a single letter, remember the first Shift + [letter];
; - after a Numpad key is pressed, typing mode should begin if the second one is another numpad key;
; - show a generic symbol for ignored dead keys; helps to clarify one was pressed;
;
; glitches to fix [by priority]:
; - [regression since v2.52] show Shift as a modifier, as Ctrl and Alt; Shift should behave as the other two; it is never displayed alone and countable;
; - once a key is pressed, counting of key fires is not initiated after the OSD was hidden for a little awhile;
; - make dead keys always work; with the current implementation, the special keys show up seemingly random in the OSD and sometimes in the text field the user types in;
;   - if dead keys support / work-around enabled, once you typed a caret [^], sometimes user gets randomly inserted carets when typing;
; - automatic resizing of the OSD/GUI is just a silly hack based on the default font size and the number of typed chars; it often fails to resize properly;
; - redraw issues; it still flickers;
; - make it work reliably with sticky keys; if user presses once Ctrl and another key afterwards, it rarely detects the combination on Winndows 7;
;----------------------------------------------------------------------------

; Initialization
#SingleInstance force
#NoEnv
#MaxHotkeysPerInterval 500
SetBatchLines, -1
ListLines, Off

; Settings.
    global DeadKeys              := 1     ; a toggle for a partial dead keys support. Zero [0] means no dead keys. See CreateHotkey() and char2skip to define the dead keys.
    global ShowSingleKey         := 1     ; show only key combinations
    global ShowMouseButton       := 1     ; if disabled, mouse click beeps will never occur
    global HideAnnoyingKeys      := 1     ; Left click and PrintScreen can easily get in the way.
    global ShowSingleModifierKey := 1     ; make it display Ctrl, Alt, Shift when pressed alone
    global DifferModifiers       := 0     ; differentiate between left and right modifiers
    global ShowPrevKey           := 1     ; show previously pressed key, if pressed quickly in succession
    global ShowPrevKeyDelay      := 300
    global ShowKeyCount          := 1     ; count how many times a key is pressed
    global ShowKeyCountFired     := 1     ; show only key presses (0) or catch key fires as well (1)
    global DisplayTime           := 3000  ; in milliseconds
    global GuiWidth              := 360
    global GuiHeight             := 50
    global GuiX                  := 50
    global GuiYa                 := 250   ; toggle between GuiYa and GuiYb with Ctrl + Alt + Shift + F9
    global GuiYb                 := 800
    global FontSize              := 19
    global OSDautosize           := 1     ; make adjustments in ShowHotkey() to match your font size
    global NumLetters            := 25    ; amount of recently typed letters to display
    global NumLettersAutosize    := 60    ; ...when OSD resizes automatically
    global CapslockBeeper        := 1     ; only when the key is released
    global KeyBeeper             := 0     ; only when the key is released
    global ModBeeper             := 0     ; beeps for every modifier, when released
    global MouseBeeper           := 0
    global BeepHiddenKeys        := 0     ; [when any beeper enabled] to beep or not when keys are not displayed by OSD/HUD
;   global TransparencyLevel     := 220   ; OSD transparency; range from 0 to 255. feature disabled, to reduce flickering

; Initialization variables. Altering these may lead to undesired results.
    global typed := ""
    global visible := 0
    global GuiY := GuiYb
    global prefixed := 0 ; hack used to determine if last keypress had a modifier
    global zcSCROL := "SCROLL LOCK"
    global tickcount_start := 0   ; timer to count repeated key presses
    global keyCount := 0
    global ShowKeyCountDelay := (ShowKeyCountFired = 0) ? 700 : 6000
    NumLetters := (OSDautosize=1) ? NumLettersAutosize : NumLetters
    global text_width := 60

    CreateGUI()
    CreateHotkey()
    return

; The script

GetSpecialKeysStates() {
    GetKeyState, ScrollState, ScrollLock, T   
    If ScrollState = D
    {
       global zcSCROL := "SCROLL LOCK ON"
    }
    else {
       global zcSCROL := "Scroll lock off"
    }
}

TypedLetter(key) {
    return typed := SubStr(typed key, -NumLetters)
}

OnMousePressed() {
    global tickcount_start := A_TickCount-500

    try {
        key := GetKeyStr()
        typed := "" ; concerning TypedLetter(" ") - it resets the content of the OSD
        ShowHotkey(key)
        SetTimer, HideGUI, % -DisplayTime
    }

    If (MouseBeeper = 1) && (ShowMouseButton = 1) && (ShowSingleKey = 1) || (MouseBeeper = 1) && (ShowSingleKey = 0) && (BeepHiddenKeys = 1)
       soundbeep, 2500, 65

}

OnKeyPressed() {
    try {
        key := GetKeyStr()
        typed := "" ; concerning TypedLetter(" ") - it resets the content of the OSD
        ShowHotkey(key)
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnLetterPressed() {
    try {
        if typed 
        {
            sleep, 25    ; this delay helps with dead keys,  but it generates errors; the following actions: stringleft,1 and stringlower help correct these
        } else
        {
        }

        key := GetKeyStr(1)     ; consider it a letter

        if prefixed
        {
            ShowHotkey(key)
        } else
        {
            StringLeft, key, key, 1
            Stringlower, key, key

            GetKeyState, CapsState, CapsLock, T
            If CapsState != D
            {
                 if GetKeyState("Shift", "P")
                {
                  StringUpper, key, key
                }
            } else
                StringUpper, key, key

            TypedLetter(key)
            ShowHotkey(typed)
        }
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnSpacePressed() {
    try {
        if typed {
            if (visible)
            {
                TypedLetter("_")
                ShowHotkey(typed)
            } else
            {
                TypedLetter("_")
                ShowHotkey(typed)
                SetTimer, HideGUI, % -DisplayTime
            }
        } else if (!typed)
        {
          key := GetKeyStr()
          ShowHotkey(key)
          SetTimer, HideGUI, % -DisplayTime
        }
    }
}

OnBspPressed() {
    try
    {
        if typed
        {
            typed := SubStr(typed, 1, StrLen(typed) - 1)
            ShowHotkey(typed)
        } else if (!typed)
        {
            key := GetKeyStr()
            ShowHotkey(key)
            SetTimer, HideGUI, % -DisplayTime
        }
    }
    if (BeepHiddenKeys = 1) && (KeyBeeper = 1) && (ShowSingleKey = 0)
       soundbeep, 1900, 45

    if (KeyBeeper = 1) && (ShowSingleKey = 1)
       soundbeep, 1900, 45
}

OnCapsPressed() {
    try
    {
        if typed
        {
            ShowHotkey(typed)
        } else if (!typed)
        {
            key := GetKeyStr()
            GetKeyState, CapsState, CapsLock, T
            if CapsState = D
            {
                key := prefixed ? key : "CAPSLOCK ON"
            } else
                key := prefixed ? key : "CapsLock off"
            ShowHotkey(key)
            SetTimer, HideGUI, % -DisplayTime
        }
    }

    If (CapslockBeeper = 1) && (ShowSingleKey = 1) || (BeepHiddenKeys = 1)
       {
        soundbeep, 450, 200
       }
}

OnNumpadPressed()
{
    GetKeyState, NumState, NumLock, T
    try {
        if NumState != D
        {
            key := GetKeyStr()
            ShowHotkey(key)
            SetTimer, HideGUI, % -DisplayTime
        } else if !typed
        {
            key := GetKeyStr()
            ShowHotkey(key)
        } else if NumState = D
        {
            key := GetKeyStr(1) ; consider it a letter
            StringLeft, key, key, 3
            StringRight, key, key, 1
            TypedLetter(key)
            ShowHotkey(typed)
        }
        SetTimer, HideGUI, % -DisplayTime
    }
}

OnKeyUp() {
    global tickcount_start := A_TickCount

    if typed && (CapslockBeeper = 1) && (ShowSingleKey = 1)
    {
        GetKeyState, CapsState, CapsLock, T
        If CapsState = D
           {
             soundbeep, 450, 25
           }
           else if (KeyBeeper = 1) && (ShowSingleKey = 1)
           {
             soundbeep, 1900, 45
           }
    }

    If (CapslockBeeper = 0) && (KeyBeeper = 1) && (ShowSingleKey = 1)
       {
         soundbeep, 1900, 45
       }
       else if (CapslockBeeper = 1) && (KeyBeeper = 0)
       {
       }
       else if !typed && (CapslockBeeper = 1) && (ShowSingleKey = 1)
       {
         soundbeep, 1900, 45
       }

    if (BeepHiddenKeys = 1) && (KeyBeeper = 1) && (ShowSingleKey = 0)
         soundbeep, 1900, 45  
}

OnModUp() {
    global tickcount_start := A_TickCount

    If (ModBeeper = 1) && (ShowSingleKey = 1) && (ShowSingleModifierKey = 1) || (ModBeeper = 1) && (BeepHiddenKeys = 1)
       soundbeep, 1000, 65

}

; ===================================================================================

CreateGUI() {
    global

    Gui, +AlwaysOnTop -Caption +Owner +LastFound +ToolWindow +E0x20
    Gui, Margin, 10, 10
    Gui, Color, 111111
    Gui, Font, cWhite s%FontSize% bold, Arial, -wrap
    Gui, Add, Text, vHotkeyText left x10 y10 -wrap

;    if TransparencyLevel between 10 and 245
;       WinSet, Transparent, %TransparencyLevel%

}

CreateHotkey() {

    Loop, 95
    {
        k := Chr(A_Index + 31)

        if (DeadKeys=1)
        {
            for each, char2skip in StrSplit("``,^,',"",~", ",")  ; dead keys to ignore
            {
                if (k = char2skip && DeadKeys=1)
                {
                    continue, 2
                }
            }
        }

        if (k = " ")
        {
            Hotkey, % "~*Space", OnSpacePressed
            Hotkey, % "~*Space Up", OnKeyUp
        }
        else
        {
            Hotkey, % "~*" k, OnLetterPressed
            Hotkey, % "~*" k " Up", OnKeyUp
        }
    }

    Hotkey, % "~*Backspace", OnBspPressed
    Hotkey, % "~*CapsLock", OnCapsPressed
    Hotkey, % "~*CapsLock Up", OnKeyUp

    Loop, 24 ; F1-F24
    {
        Hotkey, % "~*F" A_Index, OnKeyPressed
        Hotkey, % "~*F" A_Index " Up", OnKeyUp
    }

    Loop, 10 ; Numpad0 - Numpad9
    {
        Hotkey, % "~*Numpad" A_Index - 1, OnNumpadPressed
        Hotkey, % "~*Numpad" A_Index - 1 " Up", OnKeyUp
    }

    NumpadKeysList := "NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|sc04E|sc04A|sc052|sc04F|sc050|sc051|sc04B|sc04C|sc04D|sc047|sc048|sc049|sc053|sc037|sc135"

    Loop, parse, NumpadKeysList, |
    {
       Hotkey, % "~*" A_LoopField, OnNumpadPressed
       Hotkey, % "~*" A_LoopField " Up", OnKeyUp
    }

    Otherkeys := "WheelDown|WheelUp|WheelLeft|WheelRight|XButton1|XButton2|Browser_Forward|Browser_Back|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Help|Sleep|PrintScreen|CtrlBreak|Break|AppsKey|Tab|Enter|Esc"
               . "|Insert|Home|End|Up|Down|Left|Right|ScrollLock|NumLock|Pause|sc145|sc146|sc046|sc123|sc11C|sc149|sc151|sc122|sc153"
    Loop, parse, Otherkeys, |
    {
        Hotkey, % "~*" A_LoopField, OnKeyPressed
        Hotkey, % "~*" A_LoopField " Up", OnKeyUp
    }

    If ShowMouseButton=1
    {
        Loop, Parse, % "LButton|MButton|RButton", |
        Hotkey, % "~*" A_LoopField, OnMousePressed
    }

    for i, mod in ["LCtrl", "RCtrl", "LAlt", "RAlt"] {
        Hotkey, % "~*" mod, OnKeyPressed
        Hotkey, % "~*" mod " Up", OnModUp
    }

    for i, mod in ["LWin", "RWin"]
        Hotkey, % "~*" mod, OnKeyPressed
        Hotkey, % "~*" mod " Up", OnModUp

    If typed {
    for i, mod in ["LShift", "RShift"]
        Hotkey, % "~*" mod, OnKeyPressed
        Hotkey, % "~*" mod " Up", OnModUp
    }
}

ShowHotkey(HotkeyStr) {

    if GetKeyState("Shift", "D") && (HotkeyStr ~= "\^") && typed && DeadKeys && ShowSingleKey
    {
        SendRaw, ^
        return
    }

    if (OSDautosize=1)
    {
        HotkeyTextTrimmed := RegExReplace(HotkeyStr, "[^a-zA-Z]", "")
        StringLeft, HotkeyTextTrimmed, HotkeyTextTrimmed, 5
        growthFactor := 1.3
        if HotkeyTextTrimmed is upper
           growthFactor := 1.05
        text_width := (StrLen(HotkeyStr)/growthFactor)*FontSize
        text_width := (text_width<70) ? 70 : text_width+15
    } else if OSDautosize=0
    {
        text_width := GuiWidth
    }

    if !typed
    {
        StringUpper, HotkeyStr, HotkeyStr, T
    }

    GuiControl,     , HotkeyText, %HotkeyStr%
    GuiControl, Move, HotkeyText, w%text_width% left
    Gui, Show, NoActivate x%GuiX% y%GuiY% AutoSize, KeypressOSD
    visible := 1
    SetTimer, runThisRepeatedly, on, 400
}

GetKeyStr(letter := 0) {
    static modifiers := ["LCtrl", "RCtrl", "LAlt", "RAlt", "LShift", "RShift", "LWin", "RWin"]
    static repeatCount := 1

    ; If any mod but shift, go ; If shift, check if not letter

    for i, mod in modifiers
    {
        if (mod = "LShift" && typed || mod = "RShift" && typed ? (!letter && GetKeyState(mod)) : GetKeyState(mod))
            prefix .= mod " + "
    }

    if (!prefix && !ShowSingleKey)
        throw

    key := SubStr(A_ThisHotkey, 3)

    if (key ~= "i)^(LCtrl|RCtrl|LShift|RShift|LAlt|RAlt|LWin|RWin)$") {
        if (ShowSingleModifierKey = 0) || (ShowSingleKey = 0) || (A_TickCount-tickcount_start > 2000) && visible
        {
            throw
        } else
        {
             key := ""
             prefix := RTrim(prefix, "+ ")
        }

        prefix := CompactModifiers(prefix)

        if (ShowKeyCount=1) {
            if !InStr(prefix, "+") && IsDoubleClickEx() {
                if (A_ThisHotKey != A_PriorHotKey) || (ShowKeyCount=1) && (A_TickCount-tickcount_start < 700) {
                    if (++repeatCount > 1) {
                        prefix .= " (" repeatCount ")"
                    }
                } else {
                    repeatCount := 0
                }
            } else {
                repeatCount := 1
            }
        }
    } else {
        if StrLen(key)=1
        {
            key := GetKeyChar(key, "A")
        } else if ( SubStr(key, 1, 2) = "sc" ) {
            key := SpecialSC(key)
        } else if (key = "Volume_Up") || (key = "Volume_Down") {
            soundbeep, 150, 40
        } else if (key = "PrintScreen") {
            if HideAnnoyingKeys
                throw
            key := "Print Screen"
        } else if (key = "MButton") {
            key := "Middle Click"
        } else if (key = "RButton") {
            key := "Right Click"
        } else if (key = "LButton") && IsDoubleClick() {
            key := "Double-Click"
        } else if (key = "LButton") {
            if HideAnnoyingKeys
                throw
            key := "Left Click"
        }
        {
            _key := (key = "Double-Click") ? "Left Click" : key
        }

        prefix := CompactModifiers(prefix)

        static pre_prefix, pre_key, keyCount := 1
        keyCount := (key=pre_key) && (prefix = pre_prefix) ? keyCount : 1
        global ShowKeyCountDelay := (ShowKeyCountFired = 0) ? 700 : 6000
        ShowKeyCountDelay := (ShowKeyCountFired=1) ? (ShowKeyCountDelay+keyCount*100) : ShowKeyCountDelay

        if (InStr(prefix, "+")) && (A_TickCount-tickcount_start < ShowKeyCountDelay) || (!letter) && (A_TickCount-tickcount_start < ShowKeyCountDelay)
        {
            if (ShowPrevKey=1) && (A_TickCount-tickcount_start < ShowPrevKeyDelay) && !typed && !letter
            {
                ShowPrevKeyValid := 1
            } else
            {
                ShowPrevKeyValid := 0
            }
            if (prefix != pre_prefix) {
                result := (ShowPrevKeyValid=1) ? prefix key " {" pre_prefix pre_key "}" : prefix key
            } else if (ShowPrevKeyValid=1) && (key != pre_key) || (ShowKeyCount=1) && (ShowPrevKeyValid=1)
            {
                keyCount := (key=pre_key) && (ShowKeyCount=1) ? (keyCount+1) : 1
                key := (keyCount>1) && (ShowKeyCount=1) ? (key " (" keyCount ")") : (key ", " pre_key)
            } else if (ShowPrevKeyValid=0)
            {
                keyCount := (key=pre_key) && (ShowKeyCount=1) ? (keyCount+1) : 1
                key := (keyCount>1) ? (key " (" keyCount ")") : (key)
            }
        } else {
            keyCount := 1
        }

        pre_prefix := prefix
        pre_key := _key

        repeatCount := 1
    }

    prefixed := prefix ? 1 : 0
    return result ? result : prefix . key
}

CompactModifiers(stringy)
{
    if DifferModifiers = 1
    {
        StringReplace, stringy, stringy, LCtrl + RAlt, AltGr, All
        StringReplace, stringy, stringy, LCtrl + RCtrl + RAlt, RCtrl + AltGr, All
        StringReplace, stringy, stringy, RAlt, AltGr, All
        StringReplace, stringy, stringy, LAlt, Alt, All
    } else if (DifferModifiers = 0)
    {
        StringReplace, stringy, stringy, LCtrl + RAlt, AltGr, All
        ; StringReplace, stringy, stringy, LCtrl + RCtrl + RAlt, RCtrl + AltGr, All
        StringReplace, stringy, stringy, LCtrl, Ctrl, All
        StringReplace, stringy, stringy, RCtrl, Ctrl, All
        StringReplace, stringy, stringy, LShift, Shift, All
        StringReplace, stringy, stringy, RShift, Shift, All
        StringReplace, stringy, stringy, LAlt, Alt, All
        StringReplace, stringy, stringy, LWin, WinKey, All
        StringReplace, stringy, stringy, RWin, WinKey, All
        StringReplace, stringy, stringy, Ctrl + Ctrl, Ctrl, All
        StringReplace, stringy, stringy, Shift + Shift, Shift, All
        StringReplace, stringy, stringy, WinKey + WinKey, WinKey, All
        StringReplace, stringy, stringy, RAlt, AltGr, All
    }
    return stringy
}

SpecialSC(sc) {
    GetSpecialKeysStates()

    GetKeyState, NumState, NumLock, T
    If NumState = D
    {
       k := {sc046: zcSCROL, sc145: "NUM LOCK ON", sc146: "Pause", sc123: "Genius LuxeMate Scroll", sc04E: "[ + ]", sc04A: "[ - ]", sc052: "[ 0 ]", sc04F: "[ 1 ]", sc050: "[ 2 ]", sc051: "[ 3 ]", sc04B: "[ 4 ]", sc04C: "[ 5 ]", sc04D: "[ 6 ]", sc047: "[ 7 ]", sc048: "[ 8 ]", sc049: "[ 9 ]", sc053: "[ . ]", sc037: "[ * ]", sc135: "[ / ]", sc11C: "[Enter]", sc149: "Page Up", sc151: "Page Down", sc153: "Delete", sc122: "Media_Play/Pause"}
    }
    else {
       k := {sc046: zcSCROL, sc145: "Num lock off", sc146: "Pause", sc123: "Genius LuxeMate Scroll", sc04E: "[ + ]", sc04A: "[ - ]", sc052: "[Insert]", sc04F: "[End]", sc050: "[Down]", sc051: "[Page Down]", sc04B: "[Left]", sc04C: "[Undefined]", sc04D: "[Right]", sc047: "[Home]", sc048: "[Up]", sc049: "[Page Up]", sc053: "[Delete]", sc037: "[ * ]", sc135: "[ / ]", sc11C: "[Enter]", sc149: "Page Up", sc151: "Page Down", sc153: "Delete", sc122: "Media_Play/Pause"}
    }
    return k[sc]
}

; Thanks to Lexikos: https://autohotkey.com/board/topic/110808-getkeyname-for-other-languages/#entry682236
; This enables support for non-english keyboard layouts. It does not always work

GetKeyChar(Key, WinTitle:=0)
{
    thread := WinTitle=0 ? 0
        : DllCall("GetWindowThreadProcessId", "ptr", WinExist(WinTitle), "ptr", 0)
    hkl := DllCall("GetKeyboardLayout", "uint", thread, "ptr")
    vk := GetKeyVK(Key), sc := GetKeySC(Key)
    VarSetCapacity(state, 256, 0)
    VarSetCapacity(char, 4, 0)
    n := DllCall("ToUnicodeEx", "uint", vk, "uint", sc
        , "ptr", &state, "ptr", &char, "int", 2, "uint", 0, "ptr", hkl)
    return StrGet(&char, n, "utf-16")
}

IsDoubleClick(MSec = 300) {
    Return (A_ThisHotKey = A_PriorHotKey) && (A_TimeSincePriorHotkey < MSec)
}

IsDoubleClickEx(MSec = 300) {
    preHotkey := RegExReplace(A_PriorHotkey, "i) Up$")
    Return (A_ThisHotKey = preHotkey) && (A_TimeSincePriorHotkey < MSec)
}

HideGUI() {
    visible := 0
    Gui, Hide
    SetTimer, runThisRepeatedly, off, 300

}

!+^F8::
    ShowSingleKey := (!ShowSingleKey) ? true : false
    ShowHotkey("Show single keys = " ShowSingleKey)
    SetTimer, HideGUI, % -DisplayTime
return

!+^F9::
    GuiY := (GuiY = GuiYb) ? GuiYa : GuiYb
    ShowHotkey("OSD position changed")
    SetTimer, HideGUI, % -DisplayTime
return

!+^F12::
    Gui, Destroy
    sleep, 100
    CreateGUI()
    sleep, 100
    ShowHotkey("OSD reinitializing...")
    sleep, 1500
    Reload
return

runThisRepeatedly() {
    id := mouseIsOver()
    title := getWinTitleFromID(id)
    if title = KeypressOSD
    {
        HideGUI()
        sleep, 1000
    }
}

mouseIsOver() {
    MouseGetPos,,, id
    return id
}

getWinTitleFromID(id) {
    WinGetTitle, title, % "ahk_id " id
    return title
}
