$packageName  = 'ubooquity' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://vaemendis.net/ubooquity/downloads/Ubooquity-2.1.1.zip'
$checksum     = 'D7D454A99B3DB9C9F333F71F7C2A8977F3E0EA0B9B079E6370495C335AE0F600'
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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ubooquity.lnk" -targetPath "$toolsDir\Ubooquity.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\ubooquity.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ubooquity.lnk" -targetPath "$toolsDir\Ubooquity.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\ubooquity.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
