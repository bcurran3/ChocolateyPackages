$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = 'E12E88F52086DD2C14A35D9369F85CAEE3898D9886E19DBECDEAB32110CC58EE' 
$checksumType   = 'sha256'
$UnzippedEXE    = Join-Path $toolsDir 'WinaeroTweaker-0.7.0.4-setup.exe'
$installerType  = 'EXE'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
    Options = @{
    Headers = @{
      referer = "http://winaero.com/download.php?view.1796"
    }
  }  
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $UnzippedEXE
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Winaero Tweaker'
}

Install-ChocolateyInstallPackage @packageArgs						  

