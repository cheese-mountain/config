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

; Send custom f keys for space + win|ctrl
#Space::send, {F13}
^Space::send, {F15}
; Show terminal with altgr + t (used in vscode command)
~<^>!t::send, {F13}
; Find in terminal with altgr + (r)epo 
<^>!r::
    Send, {F13}
    SendInput, fd r{Enter}

; Scroll up/down with win + u/d
#u::Send {WheelUp 5}
#d::Send {WheelDown 5}

; Bind win + h/j/k/l to ←/↓/↑/→ 
#h::send, {Left}
#j::send, {Down}
#k::send, {Up}
#l::send, {Right}

; move window to target desktop number if alt is pressed, else switch view to it
switchOrMoveTo(i) {
    switchDesktopByNumber(i)
    ; if (GetKeyState("Alt")) {
    ;     MoveCurrentWindowToDesktop(i)
    ; } else {
    ;     switchDesktopByNumber(i)
    ; }
}
   
#1::switchOrMoveTo(1)
#2::switchOrMoveTo(2)
#3::switchOrMoveTo(3)
#4::switchOrMoveTo(4)
#5::switchOrMoveTo(5)
#6::switchOrMoveTo(6)
#7::switchOrMoveTo(7)
#8::switchOrMoveTo(8)
#9::switchOrMoveTo(9)
