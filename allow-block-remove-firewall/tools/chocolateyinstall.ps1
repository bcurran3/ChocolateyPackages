$ErrorActionPreference = 'Stop'
$packageName= 'allow-block-remove-firewall'
$installerType = 'ZIP'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.tweaking.com/files/setups/Tweaking.com-Right-Click_Allow_Block_or_Remove-Windows_Firewall.zip' 
$checksum   = '73E92E56E0D6E4C6D5DB49706D671587FB957FEB6EE4DC7100339959569834FA'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs


  
