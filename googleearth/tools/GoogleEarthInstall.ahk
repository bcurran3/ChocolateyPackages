#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Google Earth, User Options, 500
WinActivate
;BlockInput On
Send {Tab}
Send {Tab}
Send {Space}
Send {Tab}
Send {Enter}
WinWaitActive, Google Earth, Installation Complete, 60
Send {Enter}
;BlockInput Off

