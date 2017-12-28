$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$checksum       = 'AC8595CAF07D474F5D2BC83999C6947FB1B340D91D321FD77C8F78582BCB3426'
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

















