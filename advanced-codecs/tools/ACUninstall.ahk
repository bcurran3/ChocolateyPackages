#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
sleep 10000
If WinExist("Advanced")
 {
  WinActivate
  Send !n
 }
WinWaitActive, Windows Installer, Are you sure you want to uninstall this product? , 90
WinActivate
Send !y

