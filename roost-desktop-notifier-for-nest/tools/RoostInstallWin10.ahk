#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WINDOWS 10 
;BlockInput On
WinWaitActive, Application Install - Security Warning, Do you want to install this application? , 300
WinActivate
Send !i
;WinWaitActive, Roost Desktop Notifier, I do not agree, 60
;WinActivate
;sleep, 30000
;Send !f4
;BlockInput Off


