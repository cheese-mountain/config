# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
}

$omp_config = Join-Path $PSScriptRoot ".\oh-my-posh.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Fzf
Import-Module PSFzf
Set-PSReadLineKeyHandler -Key Ctrl+f -ScriptBlock {
    $options = "--preview 'ls {}' --height 40% --layout reverse --border"
    $path = Invoke-Expression "fd --type directory | fzf $options 2>&1"
    if ($path) {
        Invoke-Expression "code $path"
    } 
}

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
