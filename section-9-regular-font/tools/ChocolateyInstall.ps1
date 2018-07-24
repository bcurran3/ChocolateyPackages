$packageName = 'section-9-regular-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#SHA256 checksum = '3EEAA2CF8C239FCD13E76B00AB038D14947567266E7DD747EAC715B2206AF761'

Install-ChocolateyFont "$toolsDir\Section 9 Regular.ttf"
Remove-Item "$toolsDir\Section 9 Regular.ttf"
