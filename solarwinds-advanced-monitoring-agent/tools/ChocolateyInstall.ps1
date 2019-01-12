$packageName    = 'solarwinds-advanced-monitoring-agent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dashboard.systemmonitor.us/data_processor.php?function=agent_download&os=windows&versiontype=0'
$checksum       = '7A15778D232FE3B5CF10D1E409FFFE19C0849100FEB056B808E5F81CE10D3167'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'ZIP'
  url           = $url
  FileFullPath  = $toolsDir
  softwareName  = 'Advanced Monitoring Agent'
  checksum      = $checksum
  checksumType  = 'sha256'
  Options = @{
  Headers = @{
  referer = "https://dashboard.systemmonitor.us/"
  }
  } 
}
 
Get-ChocolateyWebFile @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = "$toolsDir\AGENT_10_7_12.EXE"
  silentArgs    = '/S'
  softwareName  = 'Advanced Monitoring Agent'
  }
  
Install-ChocolateyInstallPackage @packageArgs
