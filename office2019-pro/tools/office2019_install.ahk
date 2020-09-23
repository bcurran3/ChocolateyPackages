#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetTitleMatchMode, 2
;SetTitleMatchMode, fast

WinWaitActive, Microsoft Office , , 300
while WinExist("Microsoft Office")
   {
    WinActivate
    Send !c
	Sleep 5000
   }
exit

REF:
Microsoft Office
ahk_class Click2RunSetupUIClass
ahk_exe OfficeC2RClient.exe