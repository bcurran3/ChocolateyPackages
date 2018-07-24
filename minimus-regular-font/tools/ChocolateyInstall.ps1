$packageName = 'minimus-regular-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#SHA256 checksum = '060A50950B0CBBB49793AED35ACB8A53A1555ED2929CFBBFE59156D6BD5F1713'

Install-ChocolateyFont "$toolsDir\Minimus Regular.ttf"
Remove-Item "$toolsDir\Minimus Regular.ttf"
