#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Setup - pyTivo, Setup will install pyTivo into the following folder., 300
WinActivate
Send !n
Send !n
Send {SPACE}
Send !n
; ---------------- need for upgrade
;WinWaitActive, Setup - pyTivo, Which additional tasks should be performed?, 300
WinWaitActive, Setup - pyTivo, Select Additional Tasks, 300
Send !n
; Send !n
; Send !i
; then jump to Setup has finished...
; ---------------- need for upgrade
WinWaitActive, Setup - pyTivo, Set options for ToGo functions, 60
WinActivate
Send 1234567890
Send {TAB}
Send c:\temp
Send {TAB}
Send {TAB}
Send {SPACE}
Send !n
Send !i
WinWaitActive, Setup - pyTivo, Setup has finished installing pyTivo, 120
Send {SPACE}
Send !f
