$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '89EB621B9871389E9F352B227EA42614079AA8F8DB6BAC6D1C7C97C1519A9A28'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = 'D7AA968F6C1A2D3A73E69B8C43A6C6F3920644F8A4C18B2159D187D4BFCCABDE'
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

Install-BinFile -Name qdir -Path $env:programfiles\Q-Dir\Q-Dir.exe
Remove-Item $fileLocation | out-null













