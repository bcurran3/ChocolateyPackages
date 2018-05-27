$ErrorActionPreference = 'Stop'
$packageName    = 'network-inventory-advisor'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://dl.network-inventory-advisor.com/network_inventory_advisor.exe'
$checksum       = '186EA9F6CE7B394BC26CE2701EC32BD570E92293C3E85652F9EE33ED0398E3AD'
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

















