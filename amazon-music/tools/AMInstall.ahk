#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, Amazon Music, Chrome Legacy Window , 600
WinActivate
Send !{f4}
Sleep, 5000
Run, %comspec% /c taskkill /IM "Amazon Music Helper.exe" /F
;BlockInput Off


