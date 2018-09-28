$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/1947/VOD_5_7_0_20238.msi' 
$checksum       = 'D1D52EB83AB47F79D11BC189A9980A3D919AC1B68325FF6BF208E0C7413C67C2'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /norestart'
  softwareName  = '8x8 - Virtual Office'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Start-CheckandStop "8x8 - Virtual Office"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True"){
   } else {
     Start-Sleep -Seconds 5
     Start-CheckandStop "8x8 - Virtual Office"
	}
  
