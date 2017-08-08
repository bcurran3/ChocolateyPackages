#http://us2-dl.techpowerup.com/files/FgPOUfUxTgURn3uKd9sALQ/1502168858/GPU-Z.2.2.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.2.0.exe"
$checksum         = '81BEA70BF1308D508E87929D2EB32718012DA277191F8A1D61347E50EBE73F6F'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
