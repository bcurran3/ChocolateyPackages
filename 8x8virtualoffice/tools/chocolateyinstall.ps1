$ErrorActionPreference = 'Stop'
$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/1947/VOD-6.2.4-4.msi'
$checksum       = '13DF5BB07E0F6CBB56A5EC4E6795DD054976FD8F0BF821C04495690357DFA0B6'

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
  