$packageName= 'plexpy' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/JonnyWong16/plexpy/archive/v1.4.15.zip'
$checksum   = 'A9D44A3470FCACEF2373C2DE38A094608802DBC374D391459B912984E891C1B5'

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
