$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '5B8CFA60DC6BBF4B48C064FE3B4D897C278AF74ACD18C1BCD4FD7273D23AE65E'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '12F55B097E62BEE7AE7EAA93A1C292807367AE7515E80EAEF792A0809D0B333C'

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
  silentArgs    = '/S'
  validExitCodes= @(0,1)
  softwareName  = 'Q-Dir'
}
 
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name qdir -Path $env:ProgramFiles\Q-Dir\Q-Dir.exe
Remove-Item $fileLocation | out-null
