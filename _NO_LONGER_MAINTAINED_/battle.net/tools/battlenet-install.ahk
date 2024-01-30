#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, "Blizzard Battle.net Setup", 300
;WinWaitActive, ahk_class Blizzard Bootstrapper, 300
;WinWaitActive, ahk_exe Battle.net-Setup.exe, 300
WinActivate
Click, 600, 600
