#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
SetTitleMatchMode, fast

WinWait, SecureDFU,, 300
while WinExist("SecureDFU")
   {
    WinActivate
    Send {Space}
	Sleep 2000
   }
exit
