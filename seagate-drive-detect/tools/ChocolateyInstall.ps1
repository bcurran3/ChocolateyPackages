$packageName      = 'seagate-drive-detect' 
$ToolsDir         = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url              = 'http://support.seagate.com/kbimg/utils/drivedetect.exe' 
$checksum         = '740013C5AF41FE95F82FF7975AA807C94727E8C5DABFEA61957DD87DA5140B66'
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
