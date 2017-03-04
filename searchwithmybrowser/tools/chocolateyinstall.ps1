$packageName   = 'searchwithmybrowser'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://github.com/charlesmilette/SearchWithMyBrowser/releases/download/1.0.0/SWMB-setup.exe'
$checksum      = '62008A92E7DC105F4D7EF8A62B312A4C1AFEA55865508CF3DBA457A4C67E5621'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'SearchWithMyBrowser*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

