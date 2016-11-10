$packageName = 'svchost-lookup-tool'

remove-item "$env:Public\Desktop\svchost Lookup Tool.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\svchost Lookup Tool.lnk" -Force -ErrorAction 'SilentlyContinue'
