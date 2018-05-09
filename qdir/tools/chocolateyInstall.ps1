$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '34FADD79423498107C79079460B5BCFF1EA11157C7BA82B935EE4BF2EFB3CDE2'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '3C5F52F2EB094EC1C19D9089D7BB60C045685318923254213EB8D187C1776A00'
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













