#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, ReadySHARE Vault, , 500
WinActivate
;BlockInput On
Send !{f4}
;BlockInput Off

