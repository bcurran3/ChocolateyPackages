$ErrorActionPreference = 'Stop'
$packageName= 'outlook-photos' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download-outlook-photos.exclaimer.com/Setup.exe'
$checksum   = '8A1B40AAFCDA97C80A2A7D3B5636E921624C3DA0F521CD2961EA0B4BD22DDC2D'
$silentArgs = '/quiet /norestart'
$validExitCodes= @(0, 3010, 1641)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\Outlook Photos Install.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Exclaimer Outlook Photos*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Outlook Photos Install.msi"
Remove-Item "$env:ChocolateyInstall\lib\$packageName\tools\Bootstrapper_Install.bat"
