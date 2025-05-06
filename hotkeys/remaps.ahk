; Bind Caps to Esc
SetCapsLockState, AlwaysOff
CapsLock::F13
CapsLock & Space::Esc

#If, WinActive("ahk_exe Code.exe")
^e::send, {F14}
#If

; Bind Caps + x to Del
Capslock & x::send, {Del}

; Bind Caps + h/j/k/l to ←/↓/↑/→ && Caps + alt + h/j/k/l to shift + ←/↓/↑/→ 
#If, !GetKeyState("Shift") && !GetKeyState("Alt")
CapsLock & h::send, {Left}
CapsLock & j::send, {Down}
CapsLock & k::send, {Up}
CapsLock & l::send, {Right}
#If, GetKeyState("Shift") && !GetKeyState("Alt")
CapsLock & h::send, {Shift Down}{Left}{Shift Up}
CapsLock & j::send, {Shift Down}{Down}{Shift Up}
CapsLock & k::send, {Shift Down}{Up}{Shift Up}
CapsLock & l::send, {Shift Down}{Right}{Shift Up}
#If

; Bind Caps + w to close current window
CapsLock & q::send, {Alt Down}{F4}{Alt Up}}

; Open preconfigured apps with hotkeys
CapsLock & w::Run, "wt.exe", F:\
CapsLock & c::Run, % A_ScriptDir . "\shortcuts\c.lnk"
CapsLock & n::Run, % A_ScriptDir . "\shortcuts\n.lnk"
#If, !GetKeyState("Alt")
CapsLock & l::Run, % A_ScriptDir . "\shortcuts\l.lnk"
#If
CapsLock & g::Run, % A_ScriptDir . "\shortcuts\g.lnk"

; move window to target desktop number if alt is pressed, else switch view to it
switchOrMoveTo(i) {
    if (GetKeyState("Alt")) {
        MoveCurrentWindowToDesktop(i)
    } else {
        switchDesktopByNumber(i)
    }
}
   
CapsLock & 1::switchOrMoveTo(1)
CapsLock & 2::switchOrMoveTo(2)
CapsLock & 3::switchOrMoveTo(3)
CapsLock & 4::switchOrMoveTo(4)
CapsLock & 5::switchOrMoveTo(5)
CapsLock & 6::switchOrMoveTo(6)
CapsLock & 7::switchOrMoveTo(7)
CapsLock & 8::switchOrMoveTo(8)
CapsLock & 9::switchOrMoveTo(9)

#If, GetKeyState("Alt") && !GetKeyState("Shift")
CapsLock & h::switchDesktopToLeft()
CapsLock & l::switchDesktopToRight()
#If
CapsLock & tab::switchDesktopToLastOpened()
