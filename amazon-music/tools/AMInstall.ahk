#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, Amazon Music, Chrome Legacy Window , 500
WinActivate
;BlockInput On
Send !{f4}
Run, %comspec% /c taskkill /IM "Amazon Music Helper.exe" /F
;BlockInput Off

; NEED secondary text to close window

