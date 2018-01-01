#NoEnv 
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
WinWaitActive, CodeTwo Active Directory Photos Setup, Welcome to the CodeTwo Active Directory Photos Setup Wizard, 500
WinActivate
Send !n
Send !a
Send !n
Send !n
WinWaitActive, CodeTwo Active Directory Photos Setup, Ready to install, 60
Send !i
WinWaitActive, CodeTwo Active Directory Photos Setup, Completed the CodeTwo Active Directory Photos Setup Wizard, 30
Send !f
Sleep, 15000
If WinExist("Error")
  {
   Send {tab}
   Send {tab}
   Send {tab}
   Send {space}
  }
 
WinWaitActive, CodeTwo Active Directory Photos, Learn how to add Exchange email signatures with photos pulled from Active Directory, 120
Send !{f4}
Sleep, 15000
If WinExist("Error")			 
  {
   Send {tab}
   Send {tab}
   Send {tab}
   Send {space}
  }

