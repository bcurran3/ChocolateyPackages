$ErrorActionPreference = 'Stop'
$packageName  = 'openhab-addons' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$openHABdir   = "$env:ChocolateyInstall\lib\openhab\tools"
$url          = 'https://github.com/openhab/openhab2-addons/archive/2.0.0.beta2.zip'
$checksum     = 'C827AFAEA681F6D211391609567190149AD51143BFCE7FD5809D8C4492312E83'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'   
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
xcopy $toolsDir\openhab2-addons-2.0.0.beta2\*.* $openHABdir /s /y
Remove-Item $toolsDir\openhab2-addons-2.0.0.beta2 -recurse -force
