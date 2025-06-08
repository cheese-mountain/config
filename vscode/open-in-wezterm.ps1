param([string]$Path)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Create new tab
wezterm cli spawn --cwd $Path

# Activate the new tab
wezterm cli activate-tab --tab-relative 1

# Send F13 key
Start-Process -FilePath "AutoHotkey.exe" -ArgumentList "-Command", "showTerminal()" -WindowStyle Hidden
