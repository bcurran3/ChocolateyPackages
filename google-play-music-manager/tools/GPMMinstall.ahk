#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWait,Music Manager,Welcome to Google Play Music Manager , 60
WinActivate
;BlockInput On
Send {Enter}
Sleep, 100
Send !{f4}
Sleep, 100
Send {Left}
Send {Enter}
Sleep, 100
Send {Enter}
;BlockInput Off


