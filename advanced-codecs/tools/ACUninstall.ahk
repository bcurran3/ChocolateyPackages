#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Windows Installer, Are you sure you want to uninstall this product?, 300
WinActivate
;BlockInput On
Send !y
;BlockInput Off

