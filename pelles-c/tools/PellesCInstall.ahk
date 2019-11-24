#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Pelles C Setup, License Agreement , 600
WinActivate
Send {Tab}
Send {Space}
Send {Tab}
Send {Space}
Send {Space}
Send {Space}
Send {Space}
WinWaitActive, Pelles C Setup, Finished , 600
Send {Space}
