#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, ProSAFE Plus Utility - InstallShield Wizard, &OK , 300
WinActivate
Send !o
WinWaitActive, ProSAFE Plus Utility - InstallShield Wizard, &Next > , 300
Send !n
WinWaitActive, ProSAFE Plus Utility - InstallShield Wizard, &Next > , 300
Send !n
WinWaitActive, ProSAFE Plus Utility - InstallShield Wizard, Install WinPcap and Adobe AIR , 300
Send {space}
Send {tab}
Send {space}
Send !n
WinWaitActive, ProSAFE Plus Utility - InstallShield Wizard, Finish , 300
Send {space}
Send {tab}
Send {enter}
