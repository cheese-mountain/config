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
Import-Module PSEverything
function fd {
    $folders = Search-Everything `
        -Filter folder: -PathExclude `
        .pnpm-store, node_modules, .git, .pnpm, RECYCLE.BIN
    $path = $folders | fzf --height 40% --layout reverse --border --preview 'ls {}'
    if ($path) {
        Set-Location $path
    } 
}

# Utilities
function where ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function bin($empty) {
    if ($empty -eq "empty") {
        Clear-RecycleBin -Force
    } else {
        explorer.exe shell:RecycleBinFolder
    }
}
