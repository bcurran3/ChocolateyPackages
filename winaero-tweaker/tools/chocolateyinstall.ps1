$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = '56BD7D85DF2332A6EE247456E736DBE767263C3F180FD659CDD6AC4570D47C86'
$checksumType   = 'sha256'
$UnzippedEXE    = Join-Path $toolsDir 'WinaeroTweaker-0.10.1.0-setup.exe'
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

