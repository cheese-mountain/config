; Auto start notion & chrome
Run, % A_ScriptDir . "\shortcuts\n.lnk"
Run, % A_ScriptDir . "\shortcuts\g.lnk"

; Bind Caps to Esc
SetCapsLockState, AlwaysOff
CapsLock::F13
CapsLock & Space::Esc

#If, WinActive("ahk_exe Code.exe")
^e::send, {F14}
#If

; Bind Caps + x to Del
Capslock & x::send, {Del}

; Bind Caps + h/j/k/l to ←/↓/↑/→ 
#If, !GetKeyState("Alt")
CapsLock & h::send, {Blind}{Left}
CapsLock & j::send, {Blind}{Down}
CapsLock & k::send, {Blind}{Up}
CapsLock & l::send, {Blind}{Right}
#If

; Bind Caps + w to close current window
CapsLock & w::send, {Alt Down}{F4}{Alt Up}}

; Open terminal with caps + m
CapsLock & m::Run, "wt.exe", F:\

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
