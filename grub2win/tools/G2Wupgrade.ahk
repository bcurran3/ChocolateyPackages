#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Upgrade Grub2Win, , 10000
WinActivate
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Space}
Send {Tab}
Send {Space}
Sleep 40000
;WinWaitActive, Upgrade Grub2Win, Close The Setup Program , 6000
WinActivate
Send {Space}
