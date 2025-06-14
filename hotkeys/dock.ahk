; AutoHotkey script to toggle suspend/resume for dock processes
; Hotkey: Ctrl+B

; List of processes to toggle
ProcessList := ["Dock_64.exe", "dockmod.exe", "dockmod64.exe"]

; Track suspension state (0 = running, 1 = suspended)
SuspensionState := 0

; Ctrl+B hotkey
^b::
    if (SuspensionState = 0) {
        ; Currently running - suspend all processes
        SuspendProcesses()
        SuspensionState := 1
        ShowTooltip("Dock processes suspended")
    } else {
        ; Currently suspended - resume all processes
        ResumeProcesses()
        SuspensionState := 0
        ShowTooltip("Dock processes resumed")
    }
return

SuspendProcesses() {
    for index, ProcessName in ProcessList {
        if (ProcessExist(ProcessName)) {
            RunWait, cmd /c pssuspend.exe %ProcessName%, , Hide
        }
    }
}

ResumeProcesses() {
    for index, ProcessName in ProcessList {
        if (ProcessExist(ProcessName)) {
            RunWait, cmd /c pssuspend.exe -r %ProcessName%, , Hide
        }
    }
}

; Helper function to check if process exists
ProcessExist(ProcessName) {
    Process, Exist, %ProcessName%
    return ErrorLevel
}

; Show tooltip notification
ShowTooltip(Message) {
    ToolTip, %Message%
    SetTimer, RemoveToolTip, 2000
}

RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, Off
return

; Optional: Show script status on startup
^!i::
    if (SuspensionState = 0) {
        ShowTooltip("Dock processes are currently RUNNING")
    } else {
        ShowTooltip("Dock processes are currently SUSPENDED")
    }
