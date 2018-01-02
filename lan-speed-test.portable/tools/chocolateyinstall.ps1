$ErrorActionPreference = 'Stop';
$packageName  = 'lan-speed-test.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.totusoft.com/files/LAN_SpeedTestPortable.zip'
$checksum     = 'E1731799ED0B162BC043DADD87A81392657FBBABAAA879B7BD11996FC48C32F3'
$shortcutName = 'LAN Speed Test.lnk'
$portableEXE  = "$toolsDir\LAN_SpeedTestPortable.exe";

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir















