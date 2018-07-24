$packageName = 'airstream-futuropolis-regular-font'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#SHA256 checksum = '7BFBB3C7866D5F1ACD3EACCABF9E1F06CCC3479AF3D4E5A127F4FB03DFBA8C6B'

Install-ChocolateyFont "$toolsDir\Airstream Futuropolis Regular.ttf"
Remove-Item "$toolsDir\Airstream Futuropolis Regular.ttf"
