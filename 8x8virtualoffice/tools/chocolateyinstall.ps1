$ErrorActionPreference = 'Stop'
$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/19883/VOD_6.8.5-3_32-bit.msi'
$checksum       = '357FE60B812707101FC201644D26764D802218684579F3CEBB4073D2B2325F88'
$url64          = 'https://support.8x8.com/@api/deki/files/1947/VOD_6.8.5-3_64-bit.msi'
$checksum64     = 'E5ABA54F20E5C9C9A1F68837E25FDC72AF4731FC6206C3F8E695BF273C9CB850'

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

Start-CheckandStop "8x8 - Virtual Office"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True"){
   } else {
     Start-Sleep -Seconds 5
     Start-CheckandStop "8x8 - Virtual Office"
	}
  