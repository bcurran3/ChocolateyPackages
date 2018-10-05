$packageName= 'ammyy-admin' 

Start-CheckandStop "AA_v3"
remove-item "$env:Public\Desktop\Ammyy Admin.lnk" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -Force -ErrorAction 'SilentlyContinue'
