$ErrorActionPreference = 'Stop'
$packageName   = 'adaudit-plus'
$installerType = 'exe'
$silentArgs    = ''
$url           = 'https://www.manageengine.com/products/active-directory-audit/83574207/ManageEngine_ADAudit_Plus.exe' 
$checksum      = '962C5EA2FBE20CCB24EB02928A27409229F5C3CA16D43DADC9A1A93CB326BD7C'
$url64         = 'https://www.manageengine.com/products/active-directory-audit/83574207/ManageEngine_ADAudit_Plus_x64.exe' 
$checksum64    = 'BCFCA8B69A80CA6D071BC5BDCF9C01AB55C034CAC9F848B3B7F1ADB11C8CEF97'
$validExitCodes= @(0)
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path $toolsDir "ADAuditPlusInstall.ahk"

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
  softwareName  = 'ADAudit Plus*'   
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs




						  
						  
						  
						  
