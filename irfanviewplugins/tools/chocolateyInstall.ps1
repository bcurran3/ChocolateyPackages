$packageName    = 'irfanviewplugins'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\irfanview_plugins_450_setup.exe"
$checksum       = '99D9F8AE453BAA68D2C31596E5E99315F087C3FFA11E32C038038C03A4F6BD34'
$url64          = "$toolsDir\irfanview_plugins_x64_450_setup.exe"
$checksum64     = 'DE5F02302597A4C2158BC06B08D3B26BB6AB2AC8A8AF9A82CC6AD6EC75CD19D8'
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