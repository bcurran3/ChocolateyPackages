$packageName = 'go-contact-sync-mod'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\SetupGCSM-$env:ChocolateyPackageVersion.msi"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = $url
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'Go Contact Sync Mod*' 
  validExitCodes = @(0, 3010, 1641)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.msi -Force | Out-Null
