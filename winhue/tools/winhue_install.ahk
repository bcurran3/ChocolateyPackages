#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
Loop, 150
; check for .NET requirement message for 5 minutes (2*150=300s)
{
 If WinExist("Setup")
   {
    WinActivate
    Send {SPACE}
	break
   }
  Sleep 2000
}
 
