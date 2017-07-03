$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '39C543FD601C11435671F870FD439D976E43D83C335D3F077F1AA42AFA33CD87'
$url64          = 'http://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '3A127ABCD2410F589CF50DBA5DD3C01D97709D51DFFCEB4F29D5519A2736D787'
$silentArgs     = '/S'
$validExitCodes = @(0,1)
$bits = Get-ProcessorBits

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

if ($bits -eq 64)
   {
    $fileLocation = "$toolsDir\Q-Dir_Installer_x64.exe"
   } else {
    $fileLocation = "$toolsDir\Q-Dir_Installer_UC.exe"
   }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs
  
Remove-Item $fileLocation | out-null













