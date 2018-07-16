#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
sleep 15000
Loop, 150
; check for new version message for 5 minutes (2*150=300s)
{
 If WinExist("Advanced")
   {
    WinActivate
    Send !n
   }
 If WinExist("x64Components")
   {
    WinActivate
    Send !n
	ExitApp
   }
  Sleep 2000
}
 
