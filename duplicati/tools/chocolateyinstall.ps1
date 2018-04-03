$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://updates.duplicati.com/beta/duplicati-2.0.3.3_beta_2018-04-02-x86.msi' 
$checksum       = '5DB7C50E2DC0432D9F2624C86A5B943F061B68AF035E86CB29EEC6770C59DEB3'
$url64          = 'https://updates.duplicati.com/beta/duplicati-2.0.3.3_beta_2018-04-02-x64.msi' 
$checksum64     = '316199985E42C88E9C2EEE5A3CAA52E646008B8118B9B43A9082015678405BFD'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName    = $packageName
  fileType       = $installerType
  url            = $url
  url64bit       = $url64
  validExitCodes = $validExitCodes
  silentArgs     = $silentArgs
  softwareName   = 'Duplicati 2*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
