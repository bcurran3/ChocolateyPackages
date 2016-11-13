$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://updates.duplicati.com/experimental/duplicati-2.0.1.30_experimental_2016-11-03.zip' 
$checksum      = '6822850407C48511E879DFD546EA73F6534A42BFAD1675D8F16DF8D07059B1D7'
$silentArgs    = ''
$validExitCodes= @(0)
$fileLocation  = "$env:ChocolateyInstall\lib\3dmark\tools\3dmark-setup.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

  
