#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WINDOWS 10 
WinWaitActive, Application Install - Security Warning, Do you want to install this application? , 300
WinActivate
Send !i



