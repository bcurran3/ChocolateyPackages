#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ahk_class #32770 , This setup program will install the following components: , 1200
WinActivate
Send {space}
Send !n
WinWaitActive, ahk_class #32770 , License Agreement , 90
Send !y
Send !n
Sleep, 90000
WinWaitActive, ahk_class #32770 , &Next > , 900
Send !n
WinWaitActive, ahk_class #32770 , You must restart this computer , 90
Send {down}
Send !f
If WinExist("Error")
  {
   Send {space}
  }
