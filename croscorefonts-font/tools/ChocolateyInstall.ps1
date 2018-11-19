$packageName = 'croscorefonts-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyFont "$toolsDir\Arimo-Bold.ttf"
Install-ChocolateyFont "$toolsDir\Arimo-BoldItalic.ttf"
Install-ChocolateyFont "$toolsDir\Arimo-Italic.ttf"
Install-ChocolateyFont "$toolsDir\Arimo-Regular.ttf"
Install-ChocolateyFont "$toolsDir\Cousine-Bold.ttf"
Install-ChocolateyFont "$toolsDir\Cousine-BoldItalic.ttf"
Install-ChocolateyFont "$toolsDir\Cousine-Italic.ttf"
Install-ChocolateyFont "$toolsDir\Cousine-Regular.ttf"
Install-ChocolateyFont "$toolsDir\Tinos-Bold.ttf"
Install-ChocolateyFont "$toolsDir\Tinos-BoldItalic.ttf"
Install-ChocolateyFont "$toolsDir\Tinos-Italic.ttf"
Install-ChocolateyFont "$toolsDir\Tinos-Regular.ttf"
Remove-Item "$toolsDir\*.ttf" | Out-Null
