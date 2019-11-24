$ErrorActionPreference = 'Stop'
$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/1947/VOD_6_4_8_4.msi'
$checksum       = 'FEFB8DF9A60CB4AE7246C5EAC865A29B7230CDC97978BCD03BDC22F9823FD484'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /norestart'
  softwareName   = '8x8 - Virtual Office'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Start-CheckandStop "8x8 - Virtual Office"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True"){
   } else {
     Start-Sleep -Seconds 5
     Start-CheckandStop "8x8 - Virtual Office"
	}
  