$ErrorActionPreference = 'Stop'
$packageName    = 'qdir'
$global:packageMaintainer = 'BCURRAN3'
$softwareName   = 'Q-Dir'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.softwareok.com/Download/Q-Dir_Installer.zip'
$checksum       = '8629297D2013E58C1C2FFD7A71268DD80228E006C01077E4ED2728299E42862A'
$url64          = 'https://www.softwareok.com/Download/Q-Dir_Installer_x64.zip'
$checksum64     = '9C736167319803595BFC4D7E95EBDC989D55E64D8589BD4E3AB6E6AC132AE679'
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













