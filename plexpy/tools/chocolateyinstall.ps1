$packageName= 'plexpy' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://codeload.github.com/JonnyWong16/plexpy/zip/master'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'B904FA5526E1E2877DBF8A2210BF7FECA60BE633C5CD05805B8763C82579F6FB'
  checksumType  = 'sha256'   
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\PlexPy.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\plexpy-master\plexpy.py"
