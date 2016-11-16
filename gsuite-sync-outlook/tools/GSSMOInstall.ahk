#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Profile creation failure, Unable to set up a Google Apps Sync account while Microsoft, 90
WinActivate
;BlockInput On
Send {Space}
;BlockInput Off 

WinWaitActive, Please sign-in to Google Apps Sync, Sign in with your Google Account., 30
WinActivate
;BlockInput On
Send !n
;BlockInput Off 
 
WinWaitActive, Google Apps Sync™ for Microsoft Outlook® Installer, Installation complete., 10
WinActivate
;BlockInput On
Send {Space}
;BlockInput Off

