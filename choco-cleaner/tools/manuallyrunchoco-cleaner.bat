@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "\ProgramData\chocolatey\lib\choco-cleaner\tools\choco-cleaner.ps1"
echo Try ForcePS to run your PowerShell scripts easily without policy blocking from the Command Line:
echo https://chocolatey.org/packages/forceps
pause
