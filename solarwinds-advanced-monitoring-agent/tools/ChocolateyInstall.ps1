$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$CurrentVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$checksum       = 'ED81312923E72A569402A64A4859F2A6128F262E777A528B2CB9FED322D0FA06'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\AGENT_$CurrentVersion.EXE"
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Advanced Monitoring Agent'
  }
  
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\*.zip" | Out-Null
Remove-Item "$toolsDir\*.exe" | Out-Null
