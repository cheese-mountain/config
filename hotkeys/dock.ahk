#Requires AutoHotkey v1.1.33+
; AutoHotkey script to toggle suspend/resume for dock processes
; Hotkey: Ctrl+B

; Track suspension state (0 = running, 1 = suspended)
SuspensionState := 0

; Ctrl+B hotkey
^b::
    if (SuspensionState = 0) {
        SuspendProcesses()
        SuspensionState := 1
    } else {
        ResumeProcesses()
        TriggerTopHover()
        SuspensionState := 0
    }
    return

SuspendProcesses() {
    RunWait, pssuspend.exe Dock_64.exe, , Hide
    RunWait, pssuspend.exe dockmod.exe, , Hide
    RunWait, pssuspend.exe dockmod64.exe, , Hide
}

ResumeProcesses() {
    RunWait, pssuspend.exe -r Dock_64.exe, , Hide
    RunWait, pssuspend.exe -r dockmod.exe, , Hide
    RunWait, pssuspend.exe -r dockmod64.exe, , Hide
}

TriggerTopHover() {
    MouseGetPos, CurrentX, CurrentY
    MouseMove, A_ScreenWidth/2, 0, 0
    Sleep, 500
}

ShowTooltip(Message) {
    ToolTip, %Message%
    SetTimer, RemoveToolTip, 2000
}

RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, Off
    return
