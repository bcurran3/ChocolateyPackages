$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$CurrentVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$checksum       = '80D2A60545C1FF72215F0B890B2958B04C9BF1C7DE83EAFDA4D41606BC26CDBA'

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
