$packageName    = 'tmpgenc-karma'
$url            = 'http://download1.pegasys-inc.com/download_files/tmka_en/TMKA_0.0.7.72_setup_en.exe'
$checksum       = 'EAB3AC475494B92A990BEDA08E45A6D3BB0B261615C8F256C0B42A9DAFA56E08'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/s /v"/qb'
  softwareName  = 'TMPGEnc KARMA..'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
