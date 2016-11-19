$ErrorActionPreference = 'Stop'
$packageName   = 'exchange-reporter-plus'
$installerType = 'exe'
$silentArgs    = ''
$url           = 'https://www.manageengine.com/cgi-bin/download_exe?id=79-831-2016-11-14-09-48-54-97673' 
$checksum      = '81653A29DC60862166366DC9B3F286D1B299DF381975C7C9F949E23FF75D1B7C'
$url64         = 'https://www.manageengine.com/cgi-bin/download_exe?id=79-1245-2016-11-14-09-48-54-97673' 
$checksum64    = 'EB44FD2E6D8EF63B06BDF3BC0C39DA8F5255832940CA6DFB09A060B59F6D6CA9'
$validExitCodes= @(0)
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path $toolsDir "ERPInstall.ahk"

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




						  
						  
						  
						  
