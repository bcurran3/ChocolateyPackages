$ErrorActionPreference = 'Stop'
$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/19883/work_7.0.5-3_32-bit.msi'
$checksum       = '59E7A27A848156929C95E73662AD7690A14C4E7275D7B48ED953B6C63BF90506'
$url64          = 'https://support.8x8.com/@api/deki/files/1947/work_7.0.5-3_64-bit.msi'
$checksum64     = '11F0F05EC3415280A18FFC651DFDE7DE4695A6C07D6144D5BBE0B4558E50997A'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = '8x8 - Virtual Office'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Start-CheckandStop "8x8 Work"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True"){
   } else {
     Start-Sleep -Seconds 5
     Start-CheckandStop "8x8 Work"
	}
  