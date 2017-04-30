$packageName= 'pci-z' 

remove-item "$env:Public\Desktop\PCI-Z.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PCI-Z.lnk" -Force -ErrorAction 'SilentlyContinue'

