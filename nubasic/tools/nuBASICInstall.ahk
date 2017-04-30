#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
Sleep, 30000
If WinExist("Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026 Setup")			 
  {
   Send !c
   Sleep 1000
   Send !y
  }
