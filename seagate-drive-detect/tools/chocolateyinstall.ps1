$packageName= 'seagate-drive-detect' 
$url        = 'http://support.seagate.com/kbimg/utils/drivedetect.exe' 
$ToolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerPackage = Join-Path $ToolsDir "drivedetect.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = 'D49098C1A167EE6ECD5E553D163999484A78CEA47A5CA8E48F9FF4BB74D12F16'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Seagate Drive Detect.lnk" -targetPath "$ToolsDir\drivedetect.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Seagate Drive Detect.lnk" -targetPath "$ToolsDir\drivedetect.exe"
