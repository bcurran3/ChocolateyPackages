$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$CurrentVersion = ($ENV:ChocolateyPackageVersion -replace '[.]','_')
$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$checksum       = '84CE71C3CCA0B9B55E685FFD21069BC08F43851AE88C91B333FE95CA9111743C'

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
