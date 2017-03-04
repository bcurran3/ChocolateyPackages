#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, ReadyCLOUD Setup, Welcome to the ReadyCLOUD Setup Wizard, 60
WinActivate
Send !n
Send !a
WinWaitActive, ReadyCLOUD Setup, Completing the ReadyCLOUD Setup Wizard, 60
WinActivate
Send !r
Send !f
;BlockInput Off

