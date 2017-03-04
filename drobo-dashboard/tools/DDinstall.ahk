#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, Drobo Dashboard - InstallShield Wizard, Welcome to the InstallShield Wizard for Drobo Dashboard, 60
WinActivate
Send !n
Send !n
Send !a
Send !n
Send !n
Send !n
Send !i
WinWaitActive, Drobo Dashboard - InstallShield Wizard, InstallShield Wizard Completed, 60
WinActivate
Send {Tab}
Send {Space}
Send !f
;BlockInput Off

