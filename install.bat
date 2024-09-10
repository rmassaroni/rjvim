@echo off
setlocal

REM Set the config directory path
set "CONFIG_DIR=%LOCALAPPDATA%\nvim"

REM Check if Neovim is installed
where nvim >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Neovim is already installed.
) else (
    echo Neovim is not installed. Installing using Chocolatey...

    REM Install Chocolatey if not installed
    where choco >nul 2>nul
    if %ERRORLEVEL%==0 (
        echo Chocolatey is already installed.
    ) else (
        echo Installing Chocolatey...
        powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command ^
        "Set-ExecutionPolicy Bypass -Scope Process; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    )

    REM Install Neovim using Chocolatey
    echo Installing Neovim...
    choco install neovim -y
)

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Git is already installed.
) else (
    echo Git is not installed. Installing using Chocolatey...
    choco install git -y
)

REM Check if config directory exists, if not, clone the repository
if not exist "%CONFIG_DIR%" (
    echo Cloning Neovim configuration...
    git clone https://github.com/rmassaroni/rjvim.git "%CONFIG_DIR%"
) else (
    echo Neovim configuration already exists.
)

echo Installation complete!

