$packageName    = 'irfanviewplugins'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\irfanview_plugins_451_setup.exe"
$checksum       = '25FCDD3A7A52C505A827505A28CC93B2B7729559209E21F447D9C855A279279B'
$url64          = "$toolsDir\irfanview_plugins_x64_451_setup.exe"
$checksum64     = '19C3FF7168EC96972CD4ED5C8CE79C320392C6E94FD2CA024FC78B07D6953442'
$validExitCodes = @(0)
$silentArgs     = "/silent"

					  
$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
  Checksum64    = $checksum64
  ChecksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  

Remove-Item $url | out-null
Remove-Item $url64 | out-null