$packageName = 'tccle'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType    = 'exe'
$silentArgs  = '/quiet'
$url         = 'https://jpsoft.com/downloads/v14/tccle.exe'
$url64       = 'https://jpsoft.com/downloads/v14/tcclex64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType 
  url           = $url
  url64bit      = $url64
  silentArgs    = $silentArgs
  softwareName  = 'TCC LE*' 
  checksum      = 'F9140002225000258A1CF4300AF2892CBC2583A7B54397CCEA99E5F72722C7B2'
  checksumType  = 'sha256'  
  checksum64    = '11CB760522D82635ADC25081E70E57565682A047E938B33237194551BBDCC601'
  checksumType64= 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs