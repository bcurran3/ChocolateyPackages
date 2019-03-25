#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ahk_class #32770 , &Next , 6000
WinActivate
Send {space}
Send !n

WinWaitActive, ahk_exe igxpin.exe , This setup program will install the following components , 3000
WinActivate
Send !n

WinWaitActive, ahk_exe igxpin.exe , License Agreement , 3000
WinActivate
Send !y

WinWaitActive, ahk_exe igxpin.exe , Readme File Information , 3000
WinActivate
Send !n

; --------- below could be improved ----------

; kludge as there's no difference in the window information if it's installing or done
; waiting 2 minutes for drivers to finish installing
; probably should loop sending !n until the next window pops up
WinWaitActive, ahk_exe igxpin.exe , Setup Progress , 300
sleep 1200
WinActivate
Send !n

; --------- above could be improved ----------

WinWaitActive, ahk_exe igxpin.exe , Setup Is Complete , 300
Send {down}
Send !f
sleep 2000

If WinExist("Error")
  {
   Send {space}
  }
exit
