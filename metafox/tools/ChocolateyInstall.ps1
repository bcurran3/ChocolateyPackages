$packageName   = 'metafox'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\MetaFox_167.exe"
#checksum      = '505E487BDAA989267FE5AD1A142213425C0F8D85346D2624A3D1AA7C750CC2A9'

$packageArgs = @{
  packageName    = $packageName
  softwareName   = 'MetaFox*'  
  fileType       = 'EXE'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  
  file           = $url
  validExitCodes = @(0)  
  }
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url | out-null