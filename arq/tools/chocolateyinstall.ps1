$ErrorActionPreference = 'Stop'
$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = '200C1BDCEFF5385EEBC14600C3A91484B7D861D723753E581295CDE756FCBBCA'
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
