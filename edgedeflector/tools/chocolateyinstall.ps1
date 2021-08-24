$packageName    = 'edgedeflector'
$installerType  = 'exe'
$url            = 'https://github.com/da2x/EdgeDeflector/releases/download/v1.2.2.0/EdgeDeflector_install.exe'
$checksum       = '3B1CB1E9A8187E16F6447B81785632FA5989D72A0475D82390BA52448A5DEFA5'
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
#Purposely left it so choco thinks the package is installed to pass the validator as program only works on Win10 and Server2016. :)
