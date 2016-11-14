#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, ADAudit Plus Setup, Welcome to the InstallShield Wizard for ADAudit Plus, 90
WinActivate
BlockInput On
Send !n
WinWaitActive, ADAudit Plus Setup, License Agreement, 30
Send !y
WinWaitActive, ADAudit Plus Setup, Choose Destination Location, 30
Send !n
WinWaitActive, ADAudit Plus Setup, Web Server Port Selection, 30
Send !n
WinWaitActive, ADAudit Plus Setup, Registration for Technical Support (Optional), 30
Send !n
WinWaitActive, ADAudit Plus Setup, Begin Installation, 30
Send !n
WinWaitActive, ADAudit Plus Setup, InstallShield Wizard Complete, 60
Send {Space}
Send {Down}
Send {Space}
Send {Tab}
Send {Enter}
BlockInput Off

