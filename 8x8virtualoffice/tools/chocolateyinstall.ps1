$packageName    = '8x8virtualoffice'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://support.8x8.com/@api/deki/files/1947/VOD_5_9_0_20481.msi' 
$checksum       = '2124C3169DE65DF231A693691F1294B5F7A990E84210DED84FB2AE431EB23AAC'

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
  
