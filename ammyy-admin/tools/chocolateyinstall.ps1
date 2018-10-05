$packageName = 'ammyy-admin' 
$checksum    = '8BAEED8D30B9BFBFF3ADDA3496DF1552AB4BED3A7092CB7B56543F9B844B0353'

Start-CheckandStop "AA_v3"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"

if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
