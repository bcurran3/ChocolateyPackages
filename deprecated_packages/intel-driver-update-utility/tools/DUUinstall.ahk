#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; A window's title can contain WinTitle anywhere inside it to be a match. 

WinWaitActive, ahk_class WindowsForms10.Window.8.app.0.1a0e24_r6_ad1 , We invite you to , 90
WinActivate
Send {Tab}
Send {Tab}
Send {Space}





