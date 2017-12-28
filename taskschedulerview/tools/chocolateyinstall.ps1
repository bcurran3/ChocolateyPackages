$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/taskschedulerview.zip'
$checksum     = '0451676F8817C9B7A451A30FAB5C6258E6CA7F95CE36BCE6B095CE20964ED1F0'
$url64        = 'http://www.nirsoft.net/utils/taskschedulerview-x64.zip'
$checksum64   = '0195190A1EF2F2700576FBDBF676064531FD94790803780065CDD2D89FD44F71'
$shortcutName = 'TaskSchedulerView.lnk'
$exe          = 'TaskSchedulerView.exe'

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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
