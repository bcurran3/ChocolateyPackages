Choco-Sandbox.ps1 v1.0.0 (2023-10-02) - Sets up Windows Sandbox with Chocolatey Installed
Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use


You can customize your choco-sandbox environment further by editing any of the files
mentioned below. If your ChocolateyToolsDir is writeable by the host computer's Users group,
you can edit the files from within the sandbox in the C:\Users\WDAGUtilityAccount\Desktop\choco-sandbox
folder. Otherwise edit them outside the sandbox in the paths mentioned.

C:\tools\BCURRAN3\choco-sandbox\
- You can put any files you want in here and they will remain persistent as long as
  you have choco-sandbox installed.

C:\tools\BCURRAN3\choco-sandbox\packages.config.example
- Rename to packages.config and edit for any Chocolatey packages you want to have installed
  automatically. If you just rename it, it will install Google Chrome.

C:\tools\BCURRAN3\choco-sandbox\Microsoft.PowerShell_profile.ps1
- Edit this to modify your default PowerShell profile. It will be copied on every run of
  Chocolatey Sandbox. This could be overwritten if choco-sandbox is ever updated.

C:\tools\BCURRAN3\choco-sandbox\choco-sandbox.ps1
- Edit this to add any extra scripting to setup your sandbox. This could be overwritten
  if choco-sandbox is ever updated. You should use customize.ps1 mentioned below.

C:\ProgramData\chocolatey\lib\choco-sandbox\tools\choco-sandbox.wsb
- Edit this (XML file) to add more mapped folders; i.e. c:\shared. More info at:
  https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file
  This could be overwritten if choco-sandbox is ever updated.

C:\tools\BCURRAN3\choco-sandbox\choco-sandbox-customize.ps1
- Create this script and it will run in the sandbox after everything else is done. You can use
  this for things such as choco feature commands (i.e. choco feature enable -n allowGlobalConfirmation),
  add choco sources, mapping network drives, setting registry keys, etc.


Found Chocolatey Sandbox useful?
Buy me a beer at https://www.paypal.me/bcurran3donations
Become a patron at https://www.patreon.com/bcurran3
