$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = 'AB7BF4A818D6144907B6B762478CCB6CC8A509CE040A4E27EBC727DF0F0ECFEC'
$UnzippedEXE    = "$toolsDir\WinaeroTweaker-$env:packageVersion-setup.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
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
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
  softwareName  = 'Winaero Tweaker'
}

Install-ChocolateyInstallPackage @packageArgs						  

