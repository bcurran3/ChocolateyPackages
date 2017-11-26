$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = 'CC419BACE5429AA72313270C4C5A818B05E150586BD3BCDB3D0C673417FB7800'
$checksumType  = 'sha256'
$UnzippedMSI   = Join-Path $toolsDir 'ArqSetup.msi'
$installerType = 'MSI'
$silentArgs    = '/passive ACCEPT=YES'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  file          = $UnzippedMSI
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Arq*'   
}

Install-ChocolateyInstallPackage @packageArgs


