#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, DC++ 0.867 Setup, , 1500
WinActivate
Send {N}
