$packageName = 'android-insomnia-regular-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#SHA256 checksum = 'B4EFBD3713CEEBE3F3180989F55526DDC7123777827B78AA0F1A9A0095267720'

Install-ChocolateyFont "$toolsDir\Android Insomnia Regular.ttf"
Remove-Item "$toolsDir\Android Insomnia Regular.ttf"
