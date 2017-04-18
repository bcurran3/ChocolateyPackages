$packageName  = 'yakyak' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/yakyak/yakyak/releases/download/v1.4.2/yakyak-1.4.2-win32-x64.zip'
$checksum     = 'F5FB390F1AEA1397A2797E4332297426CC49F380BE7176A88B657520A528D70A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'    
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\YakYak.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\win32-x64\yakyak.exe"
