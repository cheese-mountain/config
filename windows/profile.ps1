# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

$global:downloads = "G:\data\downloads"

Set-Alias -Name vim -Value nvim

if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
}

$omp_config = Join-Path $PSScriptRoot ".\oh-my-posh.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
# Set-PSReadLineOption -PredictionViewStyle ListView

# Use window style commands (ctrl + c/v/a/x)
Set-PSReadLineOption -EditMode Windows

# Search r (repo), d (directory), f (file) or t (text)
function search($target, $all = $false) {
    $preview = @("--preview", "ls {}")
    $base_options = @("--height", "95%", "--layout", "reverse")
    $options = @("--border")
    $wd = Get-Location
    $at_root = $wd.Path -match '^[A-Za-z]:\\?$'

    switch ($target) {
        "r" {
            $filter = @(".wp-cli", "scoop", "OtherParameters", "AppData")
            $repos = Search-Everything -regularexpression ^.git$
            $items = foreach ($path in $repos) {
                $skip = $false
                foreach ($word in $filter) {
                    if ($path -like "*$word*") {
                        $skip = $true
                        break
                    }
                }
                
                if (-not $skip) {
                    Split-Path -Path $path -Parent
                }
            }
        }
        "d" {
            if ($all) {
                $items = Search-Everything -Filter "folder:"
            } elseif ($at_root) {
                $drives = Get-PSDrive -PSProvider FileSystem
                $items = @()
                foreach ($drive in $drives) {
                    try {
                        Set-Location "$($drive.Name):\"
                        $items += Search-Everything -Filter "folder:" -PathExclude `
                            .pnpm-store, node_modules, .git, .pnpm, RECYCLE.BIN
                    } catch { 
                        continue
                    }
                }
                Set-Location $wd
            } else {
                $items = Search-Everything -Filter "folder:" -PathExclude `
                    .pnpm-store, node_modules, .git, .pnpm, RECYCLE.BIN
            }
        }
        "f" {
            $preview = @("--preview", "bat --color=always --style=numbers --line-range=:500 {}")
            if ($all) {
                $items = Search-Everything -Filter "file:"
            } elseif ($at_root) {
                $drives = Get-PSDrive -PSProvider FileSystem
                $items = @()
                foreach ($drive in $drives) {
                    try {
                        Set-Location "$($drive.Name):\"
                        $items += Search-Everything -Filter "file:" -PathExclude `
                            .pnpm-store, node_modules, .git, .pnpm, RECYCLE.BIN
                    } catch { 
                        continue
                    }
                }
                Set-Location $wd
            } else {
                $items = Search-Everything -Filter "file:" -PathExclude `
                    .pnpm-store, node_modules, .git, .pnpm, RECYCLE.BIN
            }
        }
        "t" {
            if ($all) {
                $rg = "rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore --unrestricted"
            } else {
                $rg = "rg --column --line-number --no-heading --color=always --smart-case"
            }
            $reload = "reload: $rg {q} || cd ."
            $preview = @("--preview", "bat --color=always --style=numbers --highlight-line {2} {1}")
            $options = @(
                "--ansi", "--disabled", "--delimiter", ":",
                "--bind", "start:$reload", "--bind", "change:$reload", 
                 "--preview-window", "up,60%,border-bottom"
            )
            $items = "$rg """""
        }
    }

    $fzf = $base_options + $options + $preview
    return $items | fzf @fzf 
}

function fd {
    param(
        [Parameter(Position = 0)]
        [ValidateSet("r", "f", "d", "t")]
        [string]$type = "d",
        [switch]$All
    )

    Clear-Host
     
    $path = search $type $All

    if (!$path) { return }
    if ($type -in @("f", "t")) {
        Set-Location (Split-Path -Path $path -Parent)
    } else {
        Set-Location $path
    }
}

function vsc {
    param(
        [Parameter(Position = 0)]
        [ValidateSet("r", "f", "d", "t", ".")]
        [string]$type = "r"
    )

    Clear-Host
     
    if ($type -eq ".") {
        return code .
    }

    $path = search($type)

    if ($path) {
        code $path
    }
}

# Utilities
function path ($command) {
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

function timer {
    param(
        [Parameter(Position = 0)]
        [int]$Minutes,
        
        [Parameter(ParameterSetName = "CheckRemaining")]
        [switch]$Left
    )
    
    # Define a global variable to store timer information
    if (-not (Test-Path variable:global:timerInfo)) {
        $global:timerInfo = @{
            Running = $false
            StartTime = $null
            Duration = 0
            JobId = $null
        }
    }
    
    # Check if user wants to know time left
    if ($Left) {
        if (-not $global:timerInfo.Running) {
            Write-Host "No timer currently running."
            return
        }
        
        $elapsed = (Get-Date) - $global:timerInfo.StartTime
        $remaining = [math]::Max(0, $global:timerInfo.Duration - $elapsed.TotalSeconds)
        $minutesLeft = [math]::Floor($remaining / 60)
        $secondsLeft = [math]::Floor($remaining % 60)
        
        Write-Host "Time remaining: $minutesLeft minutes and $secondsLeft seconds"
        return
    }
    
    # Start a new timer
    if ($Minutes -le 0) {
        Write-Host "Please provide a valid duration in minutes."
        return
    }
    
    # Stop any existing timer
    if ($global:timerInfo.Running -and $global:timerInfo.JobId) {
        Stop-Job -Id $global:timerInfo.JobId -ErrorAction SilentlyContinue
        Remove-Job -Id $global:timerInfo.JobId -ErrorAction SilentlyContinue
        $global:timerInfo.Running = $false
    }
    
    # Set up new timer
    $durationSeconds = $Minutes * 60
    $global:timerInfo.StartTime = Get-Date
    $global:timerInfo.Duration = $durationSeconds
    $global:timerInfo.Running = $true
    
    Write-Host "Timer started for $Minutes minutes."
    
    # Create a background job for the timer
    $job = Start-Job -ScriptBlock {
        param($seconds)
        Start-Sleep -Seconds $seconds
        return "Timer completed"
    } -ArgumentList $durationSeconds
    
    $global:timerInfo.JobId = $job.Id
    
    # Register an event to handle timer completion
    Register-ObjectEvent -InputObject $job -EventName StateChanged -Action {
        if ($Event.SourceEventArgs.JobStateInfo.State -eq "Completed") {
            [console]::beep(2000, 500)
            Write-Host "`nTimer finished!"
            $global:timerInfo.Running = $false
            Unregister-Event -SourceIdentifier $eventSubscriber.SourceIdentifier
            Remove-Job -Id $global:timerInfo.JobId -Force
        }
    } | Out-Null
}
