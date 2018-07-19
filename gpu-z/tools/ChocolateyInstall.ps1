#https://www.techpowerup.com/download/techpowerup-gpu-z/
$global:packageMaintainer = 'BCURRAN3'
$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.10.0.exe"
$checksum         = '1642B993200DE0A2EA36A35C5199182EB1653118832AB819EDEC7D481E92DA3D'
$url              = "$toolsDir\$exeFile"

Show-Patreon "https://www.patreon.com/bcurran3"
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
