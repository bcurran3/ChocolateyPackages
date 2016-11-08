$packageName = 'lexe' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://www.misec.net/products/LExE.zip'
$ExeFileName = 'LExE.exe'
$ShortcutName = 'LExE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'F851F9D067F506FA3E9C4893978FCCF4FD3BB7BB536DC3B5EF2FD951D9F83798'
  checksumType  = 'sha256'
  }
  
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFileName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFileName"