# Configuration

## Table of Contents

- [Installation](#installation)
- [Terminal Setup](#terminal-setup)
- [Keybindings](#keybindings)
- [VSCode](#vscode)

## Installation

To use this configuration repository:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/config-repo.git %personal%/config
   ```
2. Open repo and install fonts under ./fonts
3. Follow the specific setup instructions in each section below.

## Terminal Setup

Follow these steps to set up the terminal environment:

1. Install latest powershell, windows terminal, terminal icons & oh my posh
2. Copy paste windows terminal settings from windows-terminal.json
3. Run ```Set-ExecutionPolicy RemoteSigned -Scope CurrentUser```
4. add . I:\path\to\profile.ps1 to $PROFILE.CurrentUserCurrentHost
5. Install powershell modules

## Keybindings

Follow these steps to set up the keybindings:

1. Open task scheduler with Win + R, 'taskschd.msc' + Enter
2. Schedule ./hotkeys/bindings.exe to run on login

## VSCode

Login and sync
