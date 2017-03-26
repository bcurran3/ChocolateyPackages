$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$softwareName   = 'WinHue*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/beta_27/WinHue.3.BETA.27.Setup.zip' 
$checksum       = '424978E4DB99A2862AFC7CEA99F6526625C7C00506B977D98ED7F842A82071DF'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$fileLocation   = "$env:ChocolateyInstall\lib\$packageName\tools\WinHue 3 BETA 27 Setup.exe"

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
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs
  
Remove-Item $fileLocation