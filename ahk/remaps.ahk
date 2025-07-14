#Requires AutoHotkey v2.0.2
#SingleInstance Force

SetCapsLockState "AlwaysOff"

; Send caret with one press
VKBA::Send "{^}{Space}"

!w::WinClose "A"

; Send custom f keys for space + win|ctrl
#Space::Send "{F13}"

; Scroll up/down with win + u/d
#u::Send "{WheelUp 5}"
#d::Send "{WheelDown 5}"

; Bind win + h/j/k/l to ←/↓/↑/→ 
#h::Send "{Left}"
#j::Send "{Down}"
#k::Send "{Up}"
#l::Send "{Right}"

; Komorebic config
Komorebic(cmd) {
    RunWait(Format("komorebic.exe {}", cmd), , "Hide")
}

; Bind alt tab to cycle stack
; LAlt & Tab::Komorebic("cycle-stack previous")

; Focus windows
!h::Komorebic("focus left")
!j::Komorebic("focus down")
!k::Komorebic("focus up")
!l::Komorebic("focus right")

!+[::Komorebic("cycle-focus previous")
!+]::Komorebic("cycle-focus next")

; Move windows
!+h::Komorebic("move left")
!+j::Komorebic("move down")
!+k::Komorebic("move up")
!+l::Komorebic("move right")

; Workspaces
#§::Komorebic("focus-workspace 0")
#1::Komorebic("focus-workspace 1")
#2::Komorebic("focus-workspace 2")
#3::Komorebic("focus-workspace 3")
#4::Komorebic("focus-workspace 4")
#5::Komorebic("focus-workspace 5")
#6::Komorebic("focus-workspace 6")
#7::Komorebic("focus-workspace 7")

; Move windows across workspaces
#+§::Komorebic("move-to-workspace 0")
#+1::Komorebic("move-to-workspace 1")
#+2::Komorebic("move-to-workspace 2")
#+3::Komorebic("move-to-workspace 3")
#+4::Komorebic("move-to-workspace 4")
#+5::Komorebic("move-to-workspace 5")
#+6::Komorebic("move-to-workspace 6")
#+7::Komorebic("move-to-workspace 7")

; TODO: quake like toggle for claude app here
^Space::Send "{F14}"
