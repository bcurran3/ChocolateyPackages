$ErrorActionPreference = 'Stop'
$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/arqbackup/Arq7.msi' 
$checksum      = '359F1A23EAAD22D3542A4A38BF5E8E8EA6146F2415BA863C3AF8728C96972F05'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /norestart'
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
