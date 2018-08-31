#NoEnv 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ahk_class #32770 , &Next , 1200
WinActivate
Send {space}
Send !n
Loop, 60
{
; Check for one time license agreement for 2 minutes (2*60-120s)
If WinExist("License Agreement")
   {
    WinActivate
    Send !y
    Send !n
	sleep 2000
   }
If WinExist("&Next")
   {
    Send !n
   }
}
Loop, 60
{
If WinExist("You must restart this computer")
  {
   Send {down}
   Send !f
   	sleep 2000
  }
}
If WinExist("Error")
  {
   Send {space}
  }
