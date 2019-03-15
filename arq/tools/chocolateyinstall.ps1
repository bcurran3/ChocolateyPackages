$ErrorActionPreference = 'Stop'
$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = 'F68ED08E15E6F1A9FE9CA31634B57DB725EAE3E3393D19F8B5AC7705CFC695A0'
$UnzippedMSI   = "$toolsDir\ArqSetup.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $UnzippedMSI
  silentArgs    = '/passive ACCEPT=YES'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'Arq*'   
}

Install-ChocolateyInstallPackage @packageArgs
