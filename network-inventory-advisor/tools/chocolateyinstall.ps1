$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$checksum       = '45671B1A3AF668FA302C1055DA73C9FA99F1922D9CF618B20DFAE43CC8726FC1'
$validExitCodes = @(0, 3010, 1641)
$SilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  validExitCodes = $validExitCodes
  silentArgs     = $SilentArgs
  softwareName   = 'Network Inventory Advisor*'
  checksum       = $checksum
  checksumType   = 'sha256'   
}

Install-ChocolateyPackage @packageArgs

















