```bash
bash <(curl https://raw.githubusercontent.com/rmassaroni/rjvim/main/install.sh)
```

```
powershell -NoProfile -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/rmassaroni/rjvim/windows/install.bat' -OutFile 'install.bat'; if (Test-Path 'install.bat') { Start-Process 'install.bat' } else { Write-Error 'Download failed' }"
```



- config button not working
- ascii colors
- multiple columns alpha
