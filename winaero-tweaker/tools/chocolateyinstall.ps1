$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = '063A0FCADC11C8B86F01D8411BE4CB3548304B33D028E5C34B0F08AE1DBA33BB'
$checksumType   = 'sha256'
$UnzippedEXE    = Join-Path $toolsDir 'WinaeroTweaker-0.9.0.0-setup.exe'
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

