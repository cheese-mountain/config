Run, wt.exe, F:\
WinWait, ahk_exe WindowsTerminal.exe
WinHide, ahk_exe WindowsTerminal.exe

showTerminal() {
    DetectHiddenWindows, On
    WinWait, ahk_exe WindowsTerminal.exe
    WinShow, ahk_exe WindowsTerminal.exe
    WinActivate, ahk_exe WindowsTerminal.exe
    DetectHiddenWindows, Off
}

hideTerminal() {
    DetectHiddenWindows, On
    WinWait, ahk_exe WindowsTerminal.exe
    WinMinimize, ahk_exe WindowsTerminal.exe
    DetectHiddenWindows, Off
}

fd() {
    showTerminal()
    SendInput, fd{Enter}
}

vsc() {
    showTerminal()
    SendInput, vsc{Enter}
}
