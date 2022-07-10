$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati.portable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.3-2.0.6.3_beta_2021-06-17/duplicati-2.0.6.3_beta_2021-06-17.zip' 
$checksum       = '85A45CE43E0F8050324854F64F130E8967D881C73C3E120CF81028C1F110CB50'
$validExitCodes = @(0)


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

  
