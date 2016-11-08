$ErrorActionPreference = 'Stop'
$packageName= 'mossawir-lan-messenger' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://master.dl.sourceforge.net/project/mossawirlm25/MossawirLanMessegner2.5.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/S' 
  softwareName  = 'Mossawir LAN Messenger*' 
  checksum      = 'F951520D14304CD8DCF1F30B6B8364DF84CA19C4273BC52D97300CD63058EF65'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
