```
powershell -NoProfile -Command "Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/rmassaroni/rjvim/cross/install.bat' -OutFile 'install.bat';
if (Test-Path 'install.bat') { Start-Process 'install.bat' } else { Write-Error 'Download failed' }"
```
