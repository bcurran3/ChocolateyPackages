$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati.portable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.2.1-2.0.2.1_beta_2017-08-01/duplicati-2.0.2.1_beta_2017-08-01.zip' 
$checksum       = 'E37D126296024A5FAE48FDC9896C97A334EEEB6B008A970AA0E1632BC13C77B0'
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

  
