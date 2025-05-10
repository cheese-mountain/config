; Auto start notion & chrome on start
Run, % A_ScriptDir . "\shortcuts\n.lnk"
Run, % A_ScriptDir . "\shortcuts\g.lnk"

; Bind Caps to Esc
SetCapsLockState, AlwaysOff
CapsLock::Esc

CapsLock & Space::switchDesktopToLastOpened()

#If, WinActive("ahk_exe Code.exe")
^e::send, {F14}
#If

; Send caret with one press
VKBA::Send, {^}{Space}

; Bind Caps + h/j/k/l to ←/↓/↑/→ 
CapsLock & h::send, {Blind}{Left}
CapsLock & j::send, {Blind}{Down}
CapsLock & k::send, {Blind}{Up}
CapsLock & l::send, {Blind}{Right}

; Bind Caps + w to close current window
CapsLock & w::send, {Alt Down}{F4}{Alt Up}}

; Toogle terminal with caps + m
CapsLock & m::showWT()

; Search repo with caps + f
CapsLock & f::
    findGHRepo() {
        showWT()
        SendInput, fd{Enter}
    }

; Open repo in vscode with caps + c
CapsLock & c::
    openGHRepo() {
        showWT()
        SendInput, vsc{Enter}
    }

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
