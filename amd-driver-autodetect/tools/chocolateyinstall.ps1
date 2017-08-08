$packageName    = 'amd-driver-autodetect'
$installerType  = 'exe'
$url            = 'https://www2.ati.com/drivers/installer/17.30/whql/radeon-crimson-relive-17.7.2-minimalsetup-170727_web.exe'
$checksum       = '110848066E57EB3F6261ACA8B7CB53AFCAC3EE85F9A7C16E97D60C963FB8E8D7'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = ''

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

