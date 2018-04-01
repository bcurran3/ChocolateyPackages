$packageName      = 'seagate-drive-detect' 
$ToolsDir         = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url              = 'http://support.seagate.com/kbimg/utils/drivedetect.exe' 
$checksum         = '4785B39DD3AC1B9E5021A413A7361ADC3C6C363DED66AF989CA28941C915461E'
$installerPackage = Join-Path $ToolsDir "drivedetect.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Seagate Drive Detect.lnk" -targetPath "$ToolsDir\drivedetect.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Seagate Drive Detect.lnk" -targetPath "$ToolsDir\drivedetect.exe"
