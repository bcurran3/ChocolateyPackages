$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = '8A1CF4A68C3052AE86BC7B8348508228AE641F0EC683AB0DF315FA8DB57C083E'
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
  checksumType  = 'sha256'
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


