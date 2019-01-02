$packageName   = 'arq' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.arqbackup.com/download/Arq.exe' 
$checksum      = '51F91CCD95EECC955611E167E40230D4EC55E499DF9BCF31E675010DE89F627A'
$UnzippedMSI   = "$toolsDir\ArqSetup.msi"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $UnzippedMSI
  silentArgs    = '/passive ACCEPT=YES'
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'Arq*'   
}

Install-ChocolateyInstallPackage @packageArgs


