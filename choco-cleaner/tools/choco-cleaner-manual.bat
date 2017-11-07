@echo off
net session >nul 2>&1
if %errorLevel% == 0 goto RunScript
  else (
   color 4e
   cls
   echo.
   echo                  ********************************************
   echo                  *  You must choose "Run as administrator"  *
   echo                  ********************************************
   echo.
   echo Hit any key to exit.
   pause > nul
  goto end
 )

:RunScript
powershell -NoProfile -ExecutionPolicy Bypass -Command "\ProgramData\chocolatey\lib\choco-cleaner\tools\choco-cleaner.ps1"
echo Pausing so you can see results.
echo Hit any key to exit.
pause > nul
:end

