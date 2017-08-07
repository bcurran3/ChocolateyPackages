$packageName    = 'registry-compressor'
$installerType  = 'exe'
$url            = 'https://www.tweaking.com/files/setups/tweaking.com_registry_compressor_setup.exe'
$checksum       = '8294A2B159BA33D4308321D8360A74C3561F11CECF2F0A805A2BAE15BC84E236'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Tweaking.com - Registry Compressor'

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

