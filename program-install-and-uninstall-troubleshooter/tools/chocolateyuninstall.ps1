$packageName= 'program-install-and-uninstall-troubleshooter' 

remove-item "$env:Public\Desktop\MS Install Uninstall Troubleshooter (Portable).lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\MS Install Uninstall Troubleshooter (Portable).lnk" -Force -ErrorAction 'SilentlyContinue'

