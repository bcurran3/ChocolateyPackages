#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Please sign-in to Google Apps Migration for Microsoft Outlook, Sign in with your Google Account., 90
WinActivate
;BlockInput On
Send !n
;BlockInput Off 


