$packageName= 'pytivo-wmcbrine' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/wmcbrine/pytivo/archive/master.zip'
$checksum   = '04B305C00B2C30793729864D2E495655A9678C0EF4F6E26BA427F8CD2E8719A3'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PyTiVo-wmcbrine.lnk" -targetPath "$env:ChocolateyInstall\lib\pytivo-wmcbrine\tools\pytivo-master\pytivo.py" -iconLocation "$env:ChocolateyInstall\lib\$packageName\tools\pytivo.ico" -workingDirectory "$env:ChocolateyInstall\lib\$packageName\tools\pytivo-master\"
