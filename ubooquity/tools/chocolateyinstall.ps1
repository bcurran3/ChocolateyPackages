$packageName= 'ubooquity' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://vaemendis.net/ubooquity/downloads/Ubooquity-1.10.1.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'F8F7A58F8E8F7CDBB76663CF0514AD269E5A19B1B1DF33226FFEC090706D1BC8'
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ubooquity.lnk" -targetPath "$env:ChocolateyInstall\lib\ubooquity\tools\Ubooquity.jar" -WorkingDirectory "$env:ChocolateyInstall\lib\ubooquity\tools"
