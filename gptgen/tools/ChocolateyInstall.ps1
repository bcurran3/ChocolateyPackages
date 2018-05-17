$packageName = 'gptgen' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://download.sourceforge.net/project/gptfdisk/gptfdisk/1.0.1/gdisk-binaries/gdisk-windows-1.0.1.zip'
$checksum    = '12CB72C557515DB3471D4A564858D230BE6ADCD24023DE0ED2BF680A05498B27'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
