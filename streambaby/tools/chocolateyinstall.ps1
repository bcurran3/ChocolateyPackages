$packageName= 'streambaby'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.sourceforge.net/project/streambaby/streambaby-0.53.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'B5A6782EE631C952A9944311ACA17C5D0B6F2B2144D19863AD0827CAA8A25C79'
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$packageName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\streambaby-0.53\streambaby.bat" -iconLocation "$env:ChocolateyInstall\lib\$packageName\tools\streambaby.ico"