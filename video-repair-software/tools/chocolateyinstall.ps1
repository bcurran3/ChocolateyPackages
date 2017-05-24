$packageName  = 'video-repair-software'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://grauonline.de/download/videorepair.zip'
$checksum     = 'AB930614FCFE6B01ABC124CF2293AB6E7B1D7B2F4AF1FCE32E48784EA47381DF'
$shortcutName = 'Video Repair Software.lnk'
$exe          = 'videorepair\gs.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\UrbanTerror43"

