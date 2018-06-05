$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$installerType  = 'MSI'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://s3.amazonaws.com/download-aws.futuremark.com/Futuremark_SystemInfo_5_10_676.msi' 
$checksum       = '543F8EC50ADF210CBEC9940B6295056F34BB30F426FBC56BAF076835B8283A4F'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Futuremark SystemInfo*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
