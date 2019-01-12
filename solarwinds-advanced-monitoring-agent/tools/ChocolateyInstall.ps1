$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$CurrentVersion = ($env:ChocolateyPackageVersion -replace '[.]','_')
$url            = "https://rm-downloads-us.logicnow.com/AGENT_$CurrentVersion.ZIP"
$checksum       = '7A15778D232FE3B5CF10D1E409FFFE19C0849100FEB056B808E5F81CE10D3167'

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
  file          = "$toolsDir\AGENT_10_7_12.EXE"
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Advanced Monitoring Agent'
  }
  
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\*.zip" | out-null
Remove-Item "$toolsDir\*.exe" | out-null
