# Configuration

## Table of Contents

- [Getting Started](#getting-started)
- [Terminal Setup](#terminal-setup)
- [Keybindings](#keybindings)
- [VSCode](#vscode)

## Getting started

1. Install github cli & run gh auth login
2. Clone the repo: ```gh repo clone cheese-mountain/config``
3. Install all fonts under ./fonts

## General customization
1. Set background.png as desktop background
2. Hide trashbin under Settings > Personalization > Themes > Desktop icon settings 
3. Uncheck animate minimize closing of windows & shadow under Advanced System settings > Performance settings
4. Install windows powertoys

### Terminal Setup

Follow these steps to set up the terminal environment:

1. Install neovim, fzf, latest powershell, windows terminal, Everything & oh my posh
2. Copy paste windows terminal settings from windows-terminal.json
3. Run ```Set-ExecutionPolicy RemoteSigned -Scope CurrentUser```
4. Run nvim $profile & insert ```. I:\path\to\this\repo\profile.ps1```
5. Run ```Install-Module PSEverything, "Terminal-Icons", PSFzf```

### Keybindings

Follow these steps to set up the keybindings:

1. Install sharpkeys & autohotkey (version 1.1)
2. Run sharpkeys & remap caps to esc
2. Open task scheduler with Win + R, 'taskschd.msc' > Create Task. Trigger should be when logged in & action is to execute ./hotkeys/build.exe

### VSCode

Login and sync
