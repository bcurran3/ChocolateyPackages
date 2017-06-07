#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
;WinWaitActive, Setup - AOMEI Backupper, , 60
;WinActivate
;Send !{f4}
Sleep, 60000
Run, %comspec% /c taskkill /IM "ABServer.exe" /F
Run, %comspec% /c taskkill /IM "ABServer.tmp" /F
;BlockInput Off


