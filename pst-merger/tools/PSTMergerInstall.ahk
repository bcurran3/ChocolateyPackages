#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, 4Team PST Merger - InstallShield Wizard, , 300
WinActivate
Send !n
Send !a
Send !n
WinWaitActive, 4Team PST Merger - InstallShield Wizard, The InstallShield Wizard has successfully installed 4Team PST Merger. , 300


