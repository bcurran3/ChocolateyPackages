$ErrorActionPreference = 'Stop'
$packageName    = 'winaero-tweaker' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://winaero.com/e107_files/downloads/winaerotweaker.zip'
$checksum       = '951D8D5538E4FB5BC0064F20FAC07D42C50842E6D9FEFB2D9A59AC5D8BF5EC0F'
$UnzippedEXE    = "$toolsDir\WinaeroTweaker-0.11.2.0-setup.exe"

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

