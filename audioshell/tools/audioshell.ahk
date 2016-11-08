#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Setup, You may need to restart your system to see AudioShell, 60
WinActivate
BlockInput On
Send {Enter}
BlockInput Off

