#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWaitActive, Setup Grub2Win, , 1500
WinActivate
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Space}
Send {Shift}+{Tab}
Send {Shift}+{Tab}
Send {Shift}+{Tab}
Send {Shift}+{Tab}
Send {Space}
;ToolTip Please wait 10 seconds for window to close.
;WinWaitActive, Setup Grub2Win, The Grub2Win setup completed successfully! , 1000
;Sleep 30000
;WinWaitActive, EFI Update Log, , 1500
Sleep 30000
;Send {Tab}
Send {Space}
;Send {Enter} 
