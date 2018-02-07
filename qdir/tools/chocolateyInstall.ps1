$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = 'E168494DA3B459FE077DC8274809EAA76387C937C8CADDF0EB4B533AB2964D74'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '5B9825AE36593EBF9B97EED062E82511495CCCA10A0698DB2351EDCC81398AB2'
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













