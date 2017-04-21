#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;pre WINDOWS 10
BlockInput On
WinWaitActive, Open File - Security Warning, Do you want to run this file? , 120
WinActivate
Send !r
WinWaitActive, Application Install - Security Warning, , 30
WinActivate
Send {I}
;WinWaitActive, Roost Desktop Notifier - Connect to my Nest account, , 60
;Send !f4
;BlockInput Off

