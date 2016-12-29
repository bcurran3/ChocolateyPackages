$packageName= 'pytivo-wmcbrine' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/wmcbrine/pytivo/archive/master.zip'
$checksum   = 'FC1C16E587AD2A591287BF00B871DA362587D435903E6CF44D5FADAB989BF70E'

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
