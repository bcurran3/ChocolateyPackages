#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, SmartControlCenter - InstallShield Wizard, Welcome to the InstallShield Wizard for SmartControlCenter, 300
WinActivate
Send !n
Send !a
Send !n
Send !n
Send !i
WinWaitActive, SmartControlCenter - InstallShield Wizard, InstallShield Wizard Completed, 60
WinActivate
Send {tab}
Send {space}
Send !f
;BlockInput Off

