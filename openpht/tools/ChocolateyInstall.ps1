$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/RasPlex/OpenPHT/releases/download/v1.8.0.148-573b6d73/OpenPHT-1.8.0.148-573b6d73-windows-x86.exe'
$checksum       = '3A8C4E7E03DC1657CBDEF56C19DE13135C43599B8F628E9D08C98D3443FB492D'


$packageArgs = @{
  packageName   = 'openpht'
  unzipLocation = $toolsDir  
  fileType      = 'exe'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/S'
  softwareName  = 'OpenPHT'
  checksum      = 'sha256'
  checksumType  = $checksumType 
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$softwareName installed." "Version $env:packageVersion."


