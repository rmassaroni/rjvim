@echo off
setlocal

REM Set the config directory path
set "CONFIG_DIR=%LOCALAPPDATA%\nvim"

REM Create the config directory if it doesn't exist
if not exist "%CONFIG_DIR%" (
    mkdir "%CONFIG_DIR%"
)

REM Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Git is already installed.
) else (
    echo Git is not installed. Installing using Chocolatey...
    where choco >nul 2>nul
    if %ERRORLEVEL%==0 (
        echo Chocolatey is already installed.
    ) else (
        echo Installing Chocolatey...
        powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command ^
        "Set-ExecutionPolicy Bypass -Scope Process; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    )
    echo Installing Git...
    choco install git -y
)

REM Check if Neovim is installed
where nvim >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Neovim is already installed.
) else (
    echo Neovim is not installed. Installing using Chocolatey...
    echo Installing Neovim...
    choco install neovim -y
)

REM Clone the repository into the config directory
if not exist "%CONFIG_DIR%\.git" (
    echo Cloning Neovim configuration...
    git clone -b windows https://github.com/rmassaroni/rjvim.git "%CONFIG_DIR%"
) else (
    echo Neovim configuration already exists.
)

echo Installation complete!

