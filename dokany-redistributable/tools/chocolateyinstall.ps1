$packageName= 'dokany-redistributable'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.0/DokanSetup_redist-1.0.0.5000.exe'
$silentArgs = '/install /passive /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dokan Library*'
  checksum      = '26D41C36AC6D704ABB81B9F5A3793877A55DF2F877C97A104EFD061FFF76B0F0'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
