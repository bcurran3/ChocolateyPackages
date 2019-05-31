$ErrorActionPreference = 'Stop'
$packageName   = 'forticlientvpn'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://filestore.fortinet.com/forticlient/downloads/FortiClientVPNSetup_6.2.0.exe'
$checksum      = '354E93E1B79AFE1F401F6FCDF5F0D84781C24AA30CC5443BC2C1AC87D1BA0188'
$url64         = 'https://filestore.fortinet.com/forticlient/downloads/FortiClientVPNSetup_6.2.0_x64.exe'
$checksum64    = '9202AF4D28A7306645A4B34DEA45EFBCFFE5C94B5DAC8333BC68185B63F88A16'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64         = $url64
  silentArgs    = '/QUIET /NORESTART'
  softwareName  = 'FortiClient VPN' 
  checksum      = $checksum
  checksum64    = $checksum64
  checksumType  = 'sha256'
  }

Install-ChocolateyPackage @packageArgs
