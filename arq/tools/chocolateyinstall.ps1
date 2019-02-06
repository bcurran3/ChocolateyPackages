$ErrorActionPreference = 'Stop'
$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = '62CBBEAD0A9DA03740788ADDE4855AE16B2535F15836196804AE019AA299392E'
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


