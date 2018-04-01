$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '42D677DCF4AAF35DB83A27856498F539E84ED2A22F9684867672B54C152AD657'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = 'EAB361B0CDA3C96C4624A66181B8A9E5535DC2574B94AAC43A4B8071B1F2553A'
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













