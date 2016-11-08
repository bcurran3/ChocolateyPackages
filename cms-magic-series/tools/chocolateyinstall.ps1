$ErrorActionPreference = 'Stop'

$packageName= 'cms-magic-series'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS_3rg_2.0.1.6F-win32.msi' 
$url64   = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS_3rg_2.0.1.6F-win64.msi' 
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'CMS'
  checksum      = 'FE680E65566A8E79A5435D14526436D9A090D58566817A01000C8B2712AD44C2'
  checksumType  = 'sha256' 
  checksum64    = '5A869F0863220B4EE270CC00CB3863D8ECD4B70937D3B66C21FA4F64F94144B9'
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
