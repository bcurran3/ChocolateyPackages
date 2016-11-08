$packageName= 'dokany'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.1/Dokan_x86.msi' 
$checksum   = '5B24B1FB5F9B65D76DF6ABDA2F3B9E56C1165B0FC94CA027C26044EF82081AAF'
$url64      = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.1/Dokan_x64.msi' 
$checksum64 = '65FF528C1B3A3D4A47325870D8C87469FF768DAED1270852DF6217FF71F5B050'
$silentArgs = '/passive /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
