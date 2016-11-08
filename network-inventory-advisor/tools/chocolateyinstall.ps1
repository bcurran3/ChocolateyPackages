$ErrorActionPreference = 'Stop'
$packageName= 'network-inventory-advisor'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$validExitCodes = @(0, 3010, 1641)
$SilentArgs = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $SilentArgs
  softwareName  = 'Network Inventory Advisor*'
  checksum      = 'FF9B850A3763094709C3FF362F5DC273B999552FA71F291C499BB10AF25816F0'
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs

















