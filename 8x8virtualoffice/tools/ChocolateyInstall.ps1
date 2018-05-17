$packageName    = '8x8virtualoffice'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/us/downloads/get/2109' 
$checksum       = 'FCEC4725767C2495AF9860D853BE01805CD254FE3E039C4EAC50E9BC7C9449A4'
$silentArgs     = '/quiet /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
