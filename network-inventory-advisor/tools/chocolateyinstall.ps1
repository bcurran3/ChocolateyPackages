$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$checksum       = '1C8CE1A8D474D3768F19F1A2EEC7D0C055A4D2BAF33D9741CF64A44833AF5532'
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

















