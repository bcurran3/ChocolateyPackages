#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
sleep 15000
If WinExist("Advanced")
 {
  WinActivate
  Send !n
 }
sleep 1000
If WinExist("Advanced")
 {
  WinActivate
  Send !n
 }
sleep 1000
If WinExist("Advanced")
 {
  WinActivate
  Send !n
 }




; for future use
;Loop, 20000
; {
;  sleep 15000
;  IfWinExist, Advanced, A newer version is available.
;   {
;    WinActivate
;    Send !n
;   }
; }
