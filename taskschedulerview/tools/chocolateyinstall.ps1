$packageName  = 'taskschedulerview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/taskschedulerview.zip'
$checksum     = '9622F53FBA59C002BD1BD667196A1AB6B65903E46BB75281444C8612101EC81A'
$url64        = 'http://www.nirsoft.net/utils/taskschedulerview-x64.zip'
$checksum64   = '4602C90A67526CD986C1B8538035F1D82B527B13B04E82A30E4F5AD62AA9DF41'
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
