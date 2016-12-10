$packageName= 'plexpy' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/JonnyWong16/plexpy/archive/v1.4.16.zip'
$checksum   = '108AE27D975B8270ACD93278FE457EE1BB28A7D1A5434B4C744855124C592CF4'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PlexPy.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\plexpy-1.4.15\plexpy.py"
