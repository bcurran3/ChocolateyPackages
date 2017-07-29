#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, Installing Drivers , OK , 1500
WinActivate
Send {ENTER}
Sleep 15000
WinWaitActive, Installing Drivers , Close , 1500
WinActivate
Send {ENTER}
