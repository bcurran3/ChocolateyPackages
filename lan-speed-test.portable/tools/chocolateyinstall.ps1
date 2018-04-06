$ErrorActionPreference = 'Stop';
$packageName  = 'lan-speed-test.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.totusoft.com/files/LAN_SpeedTestPortable.zip'
$checksum     = '7E6589CC0C9AA38B73A082E07363F60044166638ECF06891CCF7FDD4DCFE8095'
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















