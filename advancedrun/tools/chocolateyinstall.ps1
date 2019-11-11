$packageName  = 'advancedrun' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/advancedrun.zip'
$checksum     = '788D3FAA45F4A8C206CA30573B9B955CD5F9D42633E7072E8DE781BCDBA18FE5'
$url64        = 'http://www.nirsoft.net/utils/advancedrun-x64.zip'
$checksum64   = '9E541267B9A722FBEB2765992C7494F75C4F80E16929E360991FE2E424BBEEE3'
$shortcutName = 'AdvancedRun.lnk'
$exe          = 'AdvancedRun.exe'

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
