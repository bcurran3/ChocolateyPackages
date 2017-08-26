$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = 'E6ACBAD96F660CE25AE072D48B055422C3AB8A47491913980908DB5E7290E856'
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


