$packageName   = 'comicrack'
$installerType = 'exe'
$url           = 'http://comicrack.cyolito.com/files/comicrack/ComicRackSetup09178.exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs    = '/S' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType 
  url           = $url
  silentArgs    = $silentArgs 
  softwareName  = 'ComicRack*' 
  checksum      = '56DB1A1752AF146012280A660EB43D8C029789E5BAEE3E21E90F5FE1B05875A9'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

