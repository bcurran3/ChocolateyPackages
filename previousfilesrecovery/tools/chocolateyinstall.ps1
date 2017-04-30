$packageName  = 'previousfilesrecovery' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/previousfilesrecovery.zip'
$checksum     = 'C528FF1295D9A4E8F309B659F1BF7165AB1D89B1394B789E680D5646C2A3AC24'
$url64        = 'http://www.nirsoft.net/utils/previousfilesrecovery-x64.zip'
$checksum64   = '8C18F60FA2A4C5D3A60B94CC998EB7152C3358CF14B04A2D4B5795BFDAF552B2'
$shortcutName = 'PreviousFilesRecovery.lnk'
$exe          = 'PreviousFilesRecovery.exe'

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
