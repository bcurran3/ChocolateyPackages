#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ahk_class #32770 , &Next , 1200
WinActivate
Send {space}
Send !n

WinWaitActive, ahk_exe igxpin.exe , This setup program will install the following components , 1200
WinActivate
Send !n

WinWaitActive, ahk_exe igxpin.exe , License Agreement , 1200
WinActivate
Send !y

WinWaitActive, ahk_exe igxpin.exe , Readme File Information , 1200
WinActivate
Send !n

; kludge as there's no difference in the window information if it's installing or done
; waiting 1 minute for drivers to finish installing
sleep 60000
WinWaitActive, ahk_exe igxpin.exe , Setup Progress , 10
WinActivate
Send !n

WinWaitActive, ahk_exe igxpin.exe , Setup Is Complete , 1200
WinActivate
Send {down}
Send !f
sleep 2000

If WinExist("Error")
  {
   Send {space}
  }
exit
