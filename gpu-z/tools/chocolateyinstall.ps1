#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.9.0.exe"
$checksum         = '5D4A26D850FAC53190B9D2CB967CBE524ACE0FF61D271A5B617D55E8F9060F00'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
