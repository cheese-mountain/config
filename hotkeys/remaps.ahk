SetCapsLockState, AlwaysOff

; Send caret with one press
VKBA::Send, {^}{Space}

!w::
    WinClose, A
    WinActivate
    return

#If, WinActive("ahk_exe claude.exe")
^t::Send, ^k
#If

; Maximize current window to left with if width bigger than 2000 px else maximize to full screen
^!h::
    WinGetPos, x, y, w, h, A
    if (w > 2000) {
       Send, #{Left} 
    } else {
         Send, #{Up} 
    }
    return

; Send custom f keys for space + win|altgr
#Space::send, {F13}
<^>!Space::send, {F15}

; Show terminal with altgr + t (used in vscode command)
~<^>!t::send, {F13}

; Find in terminal with altgr + (r)epo 
<^>!r::fd("r")

; Scroll up/down with alt j/k
*!j::Send {Down 3}
*!k::Send {Up 3}

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
