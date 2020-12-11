$ErrorActionPreference = 'Stop'
$packageName   = 'comicrack'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://web.archive.org/web/20160405054315/http://comicrack.cyolito.com/files/comicrack/ComicRackSetup09178.exe'
$checksum      = '56DB1A1752AF146012280A660EB43D8C029789E5BAEE3E21E90F5FE1B05875A9'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'ComicRack*' 
  checksum       = $checksum
  checksumType   = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
