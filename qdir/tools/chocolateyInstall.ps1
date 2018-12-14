$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = "$toolsDir\Q-Dir_Installer.zip"
$checksum       = 'A14F8491ADE0FF78B4989C466F9D44380375433445D6231268921155245EE776'
$url64          = "$toolsDir\Q-Dir_Installer_x64.zip"
$checksum64     = '6A47BFFBEC93AE2FBE06056AC26874ED258B0F9BF512D49C17D7104D03C20CF5'

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
  silentArgs    = '/S langid=1'
  validExitCodes= @(0,1)
  softwareName  = 'Q-Dir'
}
 
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name qdir -Path $env:programfiles\Q-Dir\Q-Dir.exe
Remove-Item "$toolsDir\q*.zip" | out-null
