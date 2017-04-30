#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;BlockInput On 
WinWaitActive, Setup , Open Visual Traceroute requires WinPcap to run properly , 600
WinActivate
Send {space}
WinWaitActive, WinPcap 4.1.3 Setup , , 600
WinActivate
Send {space}
Send !n
Send !a
Send {space}
Send !i
Sleep 5000
Send !f
WinWaitActive, Setup , WinPcap installed successfully. , 600
WinActivate
Send {space}
