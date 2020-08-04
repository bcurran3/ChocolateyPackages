@echo off
if not defined ChocolateyToolsLocation set ChocolateyToolsLocation=%SystemDrive%\tools
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "%ChocolateyToolsLocation%\BCURRAN3\CNC.PS1 %1 %2 %3 %4 %5 %6 %7 %8 %9"