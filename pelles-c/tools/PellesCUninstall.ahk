#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Pelles C Uninstall, , 600
WinActivate
Send {Space}
WinWaitActive, Pelles C Uninstall, Finished , 600
Send {Space}

