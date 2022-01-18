$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$CurrentVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
#$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$url            = "https://dashboard.systemmonitor.us/data_processor.php?function=agent_download&os=windows"
$checksum       = '779C9637CE9C2E4B7A2B5489B28569C015FB2B74B705E3F777F8ED3203B65F2F'

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
