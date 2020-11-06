$ErrorActionPreference = 'Stop'
$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/arqbackup/Arq6.msi' 
$checksum      = '2909BEB12BDEED423234CE7EF638304B18886A0DDC3E247AC14EB4A8D6455ED1'
$UnzippedMSI   = "$toolsDir\Arq6.msi"

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
