#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
Sleep, 30000
If WinExist("Microsoft Visual C++ 2017 Redistributable (x64) - 14.10.25017")			 
  {
   Send !c
   Sleep 1000
   Send !y
  }
