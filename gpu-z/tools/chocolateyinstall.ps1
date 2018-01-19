#https://www.techpowerup.com/download/techpowerup-gpu-z/
$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.6.0.exe"
$checksum         = '06BB7AF22E83543FD6154930B9C1876B619383032A41590D3169F174BCCF4EB8'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
