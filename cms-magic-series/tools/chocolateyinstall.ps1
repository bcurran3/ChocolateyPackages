$packageName   = 'cms-magic-series'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-2.0.1.8C-win32.msi' 
$checksum      = 'DF60C984A122A61AFDDCB12B76A0E6C56691D3F63406C15790B2C48D9F6D1386'
$url64         = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-2.0.1.8C-win64.msi' 
$checksum64    = '951D3605EF24993387275CBA3A2C8E2B3A81C8CB4C76359D312A365E1D4A1754'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'CMS'
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
