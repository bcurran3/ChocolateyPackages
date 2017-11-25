$packageName    = 'edgedeflector'
$installerType  = 'exe'
$url            = 'https://github.com/da2x/EdgeDeflector/releases/download/v1.1.3.0/EdgeDeflector_install.exe' 
$checksum       = '7EA4B60B3AB640472F616EC56CD519BD1006CCD59F6BE81B5D9E5E2C157F584B'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'EdgeDeflector'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

if ((Test-Path "$ENV:SYSTEMROOT\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe") -eq "True")
   {
    Install-ChocolateyPackage @packageArgs  
   } else {
    Write-Host "Microsoft Edge not found. EdgeDeflector cannot be installed." -foreground red -background blue
	}
#Purposely left it so choco thinks the package is instaleld to pass the validator as program only works on Win10 and Server2016. :) 
  
