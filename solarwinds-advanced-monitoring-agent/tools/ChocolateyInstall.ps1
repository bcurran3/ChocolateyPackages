$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$CurrentVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$checksum       = 'F19423CCF7B370E70EF1D76621C2E4935A14E162DAA65E075E4170D1B6575A1F'

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
