@echo off
setlocal
cd /d "%~dp0"
powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\start-readseek.ps1" %*
echo.
echo If startup failed, check the message above. Press any key to close this launcher window.
pause >nul
endlocal
