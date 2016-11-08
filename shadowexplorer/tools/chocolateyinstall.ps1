$packageName= 'shadowexplorer' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.shadowexplorer.com/uploads/ShadowExplorer-0.9-setup.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'ShadowExplorer*' 
  checksum      = 'F81AE34252F9DAC08BFEE6C4BCE5FCA99DAF0E5FD17A0BC76637D6CBD1C2E875'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
