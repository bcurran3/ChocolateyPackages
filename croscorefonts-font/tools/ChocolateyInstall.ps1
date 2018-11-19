$packageName = 'croscorefonts-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyFont "$toolsDir\*.ttf"
Remove-Item "$toolsDir\*.ttf"
