$packageName = 'netstat-viewer' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\NetstatViewer.exe"
$checksum    = '6F50259DA1C39581BD5910ED54752B0C8FA4600C7C2F8CDF337E9276B7FAA478'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Netstat Viewer.lnk" -targetPath "$toolsDir\NetstatViewer.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Netstat Viewer.lnk" -targetPath "$toolsDir\NetstatViewer.exe"