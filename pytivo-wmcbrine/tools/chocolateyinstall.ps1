$packageName= 'pytivo-wmcbrine' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/wmcbrine/pytivo/archive/master.zip'
$checksum   = '967BBC8D5BA6CBC7C3E1DDC157D616FCABC4553918AE5AB05FE03DB6747241CF'

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
