#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;WINDOWS 10 
WinWaitActive, Application Install - Security Warning, &Install , 300
sleep 5000
Send !I
