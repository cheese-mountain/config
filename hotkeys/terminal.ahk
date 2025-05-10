; Start windows terminal minimized
Run, wt.exe, F:\, Hide, WTpid
WinWait, ahk_exe WindowsTerminal.exe
WinHide, ahk_exe WindowsTerminal.exe

showWT() {
    DetectHiddenWindows, On
    if WinExist("ahk_exe WindowsTerminal.exe") {
        WinShow, ahk_exe WindowsTerminal.exe
        WinActivate, ahk_exe WindowsTerminal.exe
    } else {
        Run, wt.exe, F:\, Hide, WTpid
        WinWait, ahk_exe WindowsTerminal.exe
        WinShow, ahk_exe WindowsTerminal.exe
        WinActivate, ahk_exe WindowsTerminal.exe
    }
    DetectHiddenWindows, Off
}

hideWT() {
    global CurrentDesktop
    DetectHiddenWindows, On
    if WinExist("ahk_exe WindowsTerminal.exe") {
        WinHide, ahk_exe WindowsTerminal.exe
        updateGlobalVariables()
        focusTheForemostWindow(CurrentDesktop)
    }
    DetectHiddenWindows, Off
}

; Intercept Alt+F4 for Windows Terminal
#IfWinActive ahk_exe WindowsTerminal.exe
!F4::hideWT()
#IfWinActive
