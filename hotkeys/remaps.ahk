SetCapsLockState, AlwaysOff

; Send caret with one press
VKBA::Send, {^}{Space}

; Bind Caps + w to close current window
#If, WinActive("ahk_exe WindowsTerminal.exe")
!w::hideTerminal()
#If, !WinActive("ahk_exe WindowsTerminal.exe")
!w::
    WinClose, A
    WinActivate
    return
#If

; Show terminal with win + Space
#Space::showTerminal()

; Send shift+u with altgr + space (used to open claude)
<^>!Space::send, +u

; Find in terminal with altgr + (r)epo (f)ile (d)irectory 
<^>!r::fd("r")
<^>!f::fd("f")
<^>!d::fd("d")

; Bind Caps + h/j/k/l to ←/↓/↑/→ 
Esc & h::send, {Blind}{Left}
Esc & j::send, {Blind}{Down}
Esc & k::send, {Blind}{Up}
Esc & l::send, {Blind}{Right}

; Navigate virtual windows with caps 
^Space::switchDesktopToLastOpened()

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

Esc::Send, {Blind}{Esc}  ; restore Escape key when pressed alone
