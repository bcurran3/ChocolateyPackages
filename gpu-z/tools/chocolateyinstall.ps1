#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.8.0.exe"
$checksum         = 'A3A295B16EABAD76813E4C302ECFF059F5143A131065BD0A7855AA5AB7284399'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
