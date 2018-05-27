$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/taskschedulerview.zip'
$checksum     = 'CE0230312DB773E237299A0A934B23C68759466B40C7ADA14231C6B61311B422'
$url64        = 'http://www.nirsoft.net/utils/taskschedulerview-x64.zip'
$checksum64   = '0D424C9021E9F3DB51E007D15768D08AE6015C3D015743E189831F0B690879C1'
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
