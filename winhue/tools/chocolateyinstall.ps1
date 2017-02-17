$ErrorActionPreference = 'Stop'
$packageName    = 'winhue'
$softwareName   = 'WinHue*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/Hyrules/WinHue3/releases/download/beta_25/WinHue.3.BETA.25.Setup.zip' 
$checksum       = 'A4DFDE20FFD7C50FA43A12C7DA2638325582A85634186DC9EBCA787605FDF31F'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$fileLocation   = "$env:ChocolateyInstall\lib\$packageName\tools\WinHue 3 BETA 25 Setup.exe"

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