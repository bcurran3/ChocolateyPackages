$packageName  = 'ubooquity' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://vaemendis.net/ubooquity/downloads/Ubooquity-2.1.0.zip'
$checksum     = '19892106AF6EC84932A41658ED9B5F0B91B661C520982969A97FBE904548594E'
$checksumType = 'sha256' 
$fileType     = 'ZIP'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ubooquity.lnk" -targetPath "$env:ChocolateyInstall\lib\ubooquity\tools\Ubooquity.jar" -WorkingDirectory "$env:ChocolateyInstall\lib\ubooquity\tools"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ubooquity.lnk" -targetPath "$env:ChocolateyInstall\lib\ubooquity\tools\Ubooquity.jar" -WorkingDirectory "$env:ChocolateyInstall\lib\ubooquity\tools"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null