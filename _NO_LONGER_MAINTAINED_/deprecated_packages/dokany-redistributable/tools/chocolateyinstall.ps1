$packageName    = 'dokany-redistributable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.2.0.1000/DokanSetup_redist.exe'
$checksum       = '29D180D9DCE272888D3943106C720EDADCA25AE9A839E1B0F25BF6FD50116AED'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/install /passive /norestart'
  softwareName   = 'Dokan Library*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
