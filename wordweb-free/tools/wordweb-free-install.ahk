#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; A window's title can contain WinTitle anywhere inside it to be a match. 

WinWaitActive, WordWeb Dictionary/Thesaurus Setup , , 90
Send {TAB}
Send {TAB}
Send {SPACE}
Send !n
Send {ENTER}
Send {ENTER}
Sleep 5000
Send !n
Send {ENTER}
