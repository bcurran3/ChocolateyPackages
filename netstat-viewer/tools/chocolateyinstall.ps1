$packageName = 'netstat-viewer' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://www.misec.net/products/NetstatViewer.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '6DB608C6E6628979431613F7DAFF65DA1AD2F2D1A46AC89B7B7199C216075CC4'
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Netstat Viewer.lnk" -targetPath "$toolsDir\NetstatViewer.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Netstat Viewer.lnk" -targetPath "$toolsDir\NetstatViewer.exe"