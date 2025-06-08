# toggle-terminal.ps1
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32 {
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        
        [DllImport("user32.dll")]
        public static extern bool IsWindowVisible(IntPtr hWnd);
        
        [DllImport("user32.dll")]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
        
        [DllImport("user32.dll")]
        public static extern bool SetForegroundWindow(IntPtr hWnd);

        [DllImport("user32.dll")]
        public static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
        
        [DllImport("user32.dll")]
        public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
        
        [DllImport("user32.dll")]
        public static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
        
        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
        public const int SW_HIDE = 0;
        public const int SW_SHOW = 5;
        public const int SW_MINIMIZE = 6;
        public const int SW_RESTORE = 9;
    }
"@


# Find Windows Terminal process
$processes = Get-Process -Name "WindowsTerminal" -ErrorAction SilentlyContinue

if ($processes) {
    $windowFound = $false
    foreach ($process in $processes) {
        $hwnd = $process.MainWindowHandle
        if ($hwnd -ne [IntPtr]::Zero) {
            # Window has a handle, show it
            [Win32]::ShowWindow($hwnd, [Win32]::SW_RESTORE)
            [Win32]::SetForegroundWindow($hwnd)
            Write-Host "Windows Terminal restored"
            $windowFound = $true
            break
        }
    }
    
    # If no main window found, try finding by class name
    if (-not $windowFound) {
        $hwnd = [Win32]::FindWindow("CASCADIA_HOSTING_WINDOW_CLASS", $null)
        if ($hwnd -ne [IntPtr]::Zero) {
            [Win32]::ShowWindow($hwnd, [Win32]::SW_SHOW)
            [Win32]::SetForegroundWindow($hwnd)
            Write-Host "Hidden Windows Terminal found and restored"
        } else {
            Write-Host "Windows Terminal process running but window not accessible"
        }
    }
} else {
    # If no Windows Terminal found, start it
    Start-Process "wt.exe"
    Write-Host "Windows Terminal started"
}
