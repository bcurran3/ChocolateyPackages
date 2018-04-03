$packageName  = 'tautulli' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/Tautulli/Tautulli/archive/v2.0.28.zip'
$checksum     = '1B340AF8CBB1B204055383033A786D5C074E5F9DB57A38747652FDC30571AF60'
$extractDir   = 'Tautulli-2.0.28'
$shortcutName = 'Tautulli.lnk'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
