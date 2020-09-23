$packageName    = 'tmpgenc-mpeg-smart-renderer'
$url            = 'http://download1.pegasys-inc.com/download_files/tmsr5_en/TMSR5_Retail_5.0.17.23_setup_en.exe'
$checksum       = '45084C5322B54000E672E1C4833E759FAFC5F8B19245E440096C452458B2108F'

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

# Needs AHK to install