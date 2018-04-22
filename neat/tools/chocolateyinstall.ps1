$packageName    = 'neat'
$installerType  = 'exe'
$url            = 'https://s3.amazonaws.com/legacy-installers/latest/Neat_v5.7.1.474_FULL.sfx.exe'
$checksum       = '19E5C4A1351B948FA6E140AFEF8BD6C0A605BF41032DA5AFDF196E6E34979616'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Neat*'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

