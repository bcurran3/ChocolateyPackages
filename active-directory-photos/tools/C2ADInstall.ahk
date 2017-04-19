#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, CodeTwo Active Directory Photos Setup, Welcome to the CodeTwo Active Directory Photos Setup Wizard, 500
WinActivate
;BlockInput On
Send !n
Send !a
Send !n
Send !n
Send {Enter}
WinWaitActive, CodeTwo Active Directory Photos Setup, Completed the CodeTwo Active Directory Photos Setup Wizard, 60
Send !f
WinWaitActive, CodeTwo Active Directory Photos, Active Directory containers, 60
Send !{f4}
;BlockInput Off

