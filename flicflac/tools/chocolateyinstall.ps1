$packageName  = 'flicflac' 
$softwareName = 'FlicFlac*' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.sector-seven.net/assets/software/flicflac/flicflac.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = 'FF690CCA74F63D5DB3FA24617D4CA020DAA86760E042DFAC6722101E900864E7'
  checksumType  = 'sha256'    
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\FlicFlac.lnk" -targetPath "$env:ChocolateyInstall\lib\flicflac\tools\FlicFlac.exe"
