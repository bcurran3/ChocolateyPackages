$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url            = "$toolsDir\Q-Dir_Installer.zip"
$checksum       = 'DAC3FD356F543007B08FFE9AC43CEE3752A47DF06EEF91B0546678C5B1364FC4'
$url64          = "$toolsDir\Q-Dir_Installer_x64.zip"
$checksum64     = '495082A9A9318F00F04841CEAC86148A7B3F65D91F9682FB7DEE8C76CB6EBB38'

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

Install-BinFile -Name qdir -Path $env:ProgramFiles\Q-Dir\Q-Dir.exe
Remove-Item "$toolsDir\q*.zip" | out-null
