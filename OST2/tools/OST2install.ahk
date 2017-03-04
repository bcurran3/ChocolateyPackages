#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, 4Team OST2, Select the language for the installation, 60
WinActivate
Send !o
WinWaitActive, 4Team OST2, Welcome to the InstallShiled Wizard for 4Team OST2, 30
WinActivate
Send !n
WinWaitActive, 4Team OST2, License Agreement, 30
WinActivate
Send !a
Send !n
WinWaitActive, 4Team OST2, InstallShield Wizard Completed, 30
WinActivate
Send {Tab}
Send {Space}
Send !f
;BlockInput Off

