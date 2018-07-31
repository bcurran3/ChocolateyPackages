#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ahk_exe com.rovio.angrybirdsstarwars.ads.iap.exe, Terms of Service , 600
WinActivate
Send {space}
Send {tab}
Send {enter}
