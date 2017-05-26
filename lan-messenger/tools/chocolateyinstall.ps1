$packageName= 'lan-messenger' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.sourceforge.net/project/lanmsngr/1.2.35/lmc-1.2.35-win32.exe'
$checksum   = 'EAB7C8C3D7C9C82BC7E6860E78D82049DBFEA74943ED59CB1145B9DCB7124386'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/S' 
  softwareName  = 'LAN Messenger*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
