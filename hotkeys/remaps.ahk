SetCapsLockState, AlwaysOff

#If, WinActive("ahk_exe Code.exe")
^e::send, {F14}
#If

; Send caret with one press
VKBA::Send, {^}{Space}

; Bind Caps + h/j/k/l to ←/↓/↑/→ 
Esc & h::send, {Blind}{Left}
Esc & j::send, {Blind}{Down}
Esc & k::send, {Blind}{Up}
Esc & l::send, {Blind}{Right}

; Bind Caps + w to close current window
#If, WinActive("ahk_exe WindowsTerminal.exe")
Esc & w::hideTerminal()
#If, !WinActive("ahk_exe WindowsTerminal.exe")
Esc & w::send, !{F4}
#If

; Show terminal with caps + m
Esc & m::showTerminal()

; Search repos with caps + f
Esc & f::fd()

; Open repo in vscode with caps + c
Esc & c::vsc()

; move window to target desktop number if alt is pressed, else switch view to it
switchOrMoveTo(i) {
    if (GetKeyState("Alt")) {
        MoveCurrentWindowToDesktop(i)
    } else {
        switchDesktopByNumber(i)
    }
}
   
Esc & 1::switchOrMoveTo(1)
Esc & 2::switchOrMoveTo(2)
Esc & 3::switchOrMoveTo(3)
Esc & 4::switchOrMoveTo(4)
Esc & 5::switchOrMoveTo(5)
Esc & 6::switchOrMoveTo(6)
Esc & 7::switchOrMoveTo(7)
Esc & 8::switchOrMoveTo(8)
Esc & 9::switchOrMoveTo(9)

Esc & Space::switchDesktopToLastOpened()

Esc::Send, {Blind}{Esc}  ; restore Escape key when pressed alone
