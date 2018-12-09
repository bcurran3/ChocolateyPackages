$ErrorActionPreference = 'Stop'
$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'TaskSchedulerView.lnk'
$exe          = 'TaskSchedulerView.exe'
$url          = "$toolsDir\taskschedulerview.zip"
$checksum     = '44E4DD0162BBAB755AE7D33D0C5D73B6CAC4406C2FA50490C488978D09BE5D46'
$url64        = "$toolsDir\taskschedulerview-x64.zip"
$checksum64   = 'EEE2FB9058425797AB6E939E0E609BE7D4EF73B6FB3BA3894EF3D5838268385E'

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
Remove-Item "$toolsDir\*.zip" | out-null

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
