$ErrorActionPreference = 'Stop'
$packageName   = 'exchange-reporter-plus'
$installerType = 'exe'
$silentArgs    = ''
$url           = 'https://download.manageengine.com/products/exchange-reports/54226/ManageEngine_ExchangeReporterPlus.exe' 
$checksum      = 'C896F8AF8554CB49A12315FDFE155E4B1F101069F672CF0310B26A995038DF82'
$url64         = 'https://download.manageengine.com/products/exchange-reports/54226/ManageEngine_ExchangeReporterPlus_64.exe' 
$checksum64    = '989C133FE09E922236662858E4044B045EED9084A805D5FB669E7438E2952F12'
$validExitCodes= @(0)
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path $toolsDir "ExchangeReporterPlusInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
  softwareName  = 'Exchange Reporter Plus*'   
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs




						  
						  
						  
						  
