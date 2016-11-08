$ErrorActionPreference = 'Stop';
$packageName= 'lan-speed-test-lite'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://totusoft.com/files/LAN_SpeedTest.exe'
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
$installerPackage = Join-Path $scriptDir "LAN_SpeedTest.exe";

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = '431DA01ED05673F259BC33572E3A6AB8E6A5F623FA535B2CF2A00BB83245B7BD'
  checksumType  = 'sha256'
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\LAN Speed Test.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\LAN_SpeedTest.exe"















