$packageName = 'ubooquity' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://vaemendis.net/ubooquity/downloads/Ubooquity-2.0.2.zip'
$checksum    = '814650CCC44F624BE006ED6129140FBA4F064691E3A68BFE7138FDB49FC94AD4'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ubooquity.lnk" -targetPath "$env:ChocolateyInstall\lib\ubooquity\tools\Ubooquity.jar" -WorkingDirectory "$env:ChocolateyInstall\lib\ubooquity\tools"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ubooquity.lnk" -targetPath "$env:ChocolateyInstall\lib\ubooquity\tools\Ubooquity.jar" -WorkingDirectory "$env:ChocolateyInstall\lib\ubooquity\tools"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null