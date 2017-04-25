#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, , This setup program will install the following components , 1200
WinActivate
Send {space}
Send !n
WinWaitActive, , License Agreement , 60
Send !y
Send !n
Sleep, 30000
WinWaitActive, , Setup Progress , 60
Send !n
WinWaitActive, , Setup Is Complete , 60
Send {down}
Send !f
If WinExist("Error")
  {
   Send {space}
  }
;BlockInput Off



