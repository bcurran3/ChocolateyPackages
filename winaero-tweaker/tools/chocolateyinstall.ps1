$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = 'CCA7DE9FDA22B467A999FFA74534067AC52B31AE86D464F64E77E66B8BFE0C06' 
$UnzippedEXE    = Join-Path $toolsDir 'WinaeroTweaker-0.7.0.0-setup.exe'
$installerType  = 'EXE'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '470808928DA3EA21504BD9B43A5033719A39019B73A40ADA19612A6127A51735'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$url = $UnzippedEXE

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $UnzippedEXE
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Winaero Tweaker'   
}

Install-ChocolateyInstallPackage @packageArgs						  

