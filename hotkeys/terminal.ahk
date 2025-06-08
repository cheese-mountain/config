toggleTerminal() {
    Process, Exist, wezterm-gui.exe
    if (ErrorLevel = 0) {
        Run, wezterm.exe
    } else {
        IfWinActive, ahk_exe wezterm-gui.exe 
        {
            WinHide, ahk_exe wezterm-gui.exe
        } else {
            WinShow, ahk_exe wezterm-gui.exe
            WinActivate, ahk_exe wezterm-gui.exe
        }
    }
}

openWezTermFromClipboard() {
    ; Get path from clipboard (set by VS Code task)
    path := Clipboard
    
    ; Create new tab
    RunWait, wezterm cli spawn --cwd "%path%", , Hide
    
    ; Activate the new tab
    RunWait, wezterm cli activate-tab --tab-relative 1, , Hide
    
    ; Show and focus WezTerm
    showTerminal()
}

showTerminal() {
    Process, Exist, wezterm-gui.exe
    if (ErrorLevel = 0) {
        Run, wezterm.exe
    } else {
        WinShow, ahk_exe wezterm-gui.exe
        WinActivate, ahk_exe wezterm-gui.exe
    }
}

hideTerminal() {
    WinHide, ahk_exe wezterm-gui.exe
}

fd(char) {
    showTerminal()
    SendInput, fd %char%{Enter}
}

vsc(char) {
    if (GetKeyState("Alt")) {
        showTerminal()
        SendInput, vsc %char%{Enter}
    }
}
