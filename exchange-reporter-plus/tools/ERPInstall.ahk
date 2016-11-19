#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Welcome to the InstallShield Wizard for Exchange Reporter Plus, 90
WinActivate
;BlockInput On
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, License Agreement, 30
Send !y
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Choose Destination Location, 30
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Web Server Port Selection, 30
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Program Folder, 30
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Registration for Technical Support (Optional), 30
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, Begin Installation, 30
Send !n
WinWaitActive, Exchange Reporter Plus 5.1 Setup, InstallShield Wizard Complete, 60
Send {Space}
Send {Down}
Send {Space}
Send {Tab}
Send {Enter}
;BlockInput Off

