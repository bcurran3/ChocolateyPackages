#http://us2-dl.techpowerup.com/files/MAbyJ5IKUWmuG5VAXVL3uQ/1504659091/GPU-Z.2.3.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.2.0.exe"
$checksum         = 'FDD4CD909CDCF27512F5B9F3F01B1BABB10FC6A43321DF352A062684C10F026B'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
