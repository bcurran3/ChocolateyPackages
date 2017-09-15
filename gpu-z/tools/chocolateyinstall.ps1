#http://us2-dl.techpowerup.com/files/yxcEix24ClvB6lg10fzh8g/1505126530/GPU-Z.2.4.0.exe

$packageName      = 'gpu-z'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeFile          = "GPU-Z.2.4.0.exe"
$checksum         = 'DBC5CC8705A484600C4039DE2D9248B31D3DE25B142BFB1A1523E70C0337C41E'
$url              = "$toolsDir\$exeFile"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\GPU-Z.lnk" -targetPath $url
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\GPU-Z.lnk" -targetPath $url
