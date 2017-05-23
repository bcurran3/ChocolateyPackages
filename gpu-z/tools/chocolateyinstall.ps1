#http://us2-dl.techpowerup.com/files/zqWQL0Zwp-N0t9JLcvZ-jg/1495567080/GPU-Z.2.1.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.1.0.exe"
$checksum         = '5DFE5CA1602B7161FF3EEC13A8B52C9B0EFFB67233353E3C60CE0A3011147B3E'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
