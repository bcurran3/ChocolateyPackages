$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$global:packageMaintainer = 'BCURRAN3'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '9FA3616DB99DBB4A265D7AAF887791E39B01554BCC4A85F6D24638D5BA1BEB04'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '9E596E9C01A6B92335A9AEAE33459FF24718477F21CA363233D0D3896DD4DE7E'
$silentArgs     = '/S langid=1'
$validExitCodes = @(0,1)
$bits           = Get-ProcessorBits

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
 
Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyInstallPackage @packageArgs
Show-ToastMessage "$softwareName installed." "Version $env:packageVersion."

Install-BinFile -Name qdir -Path $env:programfiles\Q-Dir\Q-Dir.exe
Remove-Item $fileLocation | out-null













