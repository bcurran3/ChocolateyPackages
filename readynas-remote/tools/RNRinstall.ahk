#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, ReadyNAS Remote Setup, Welcome to the ReadyNAS Remote Setup Wizard, 300
WinActivate
Send !n
Send {Enter}
Send !n
Send !i
WinWaitActive, ReadyNAS Remote Setup, Completing the ReadyNAS Remote Setup Wizard, 300
WinActivate
Send !r
Send !f
;BlockInput Off

