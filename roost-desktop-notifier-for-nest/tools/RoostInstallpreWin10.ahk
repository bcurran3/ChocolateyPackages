#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;pre WINDOWS 10 (8)
Sleep 30000
If WinExist, ahk_class #32770 , , ,
WinActivate
Send !a
WinWaitActive, Application Install - Security Warning, Do you want to install this application?, 120
WinActivate
Send !i
WinWaitActive, Open File, , 90
WinActivate
Send !{F4}


