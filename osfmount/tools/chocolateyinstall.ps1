$ErrorActionPreference = 'Stop'
$packageName = 'osfmount' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits        = Get-ProcessorBits
$url         = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum    = '5348838DD60607057DBD1448E5173D1C4C6280B82AFE9967A837499822FC8C5D'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'  
  url64bit      = $url
  checksum64    = $checksum
  checksumType64= 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'OSFMount*' 
  }

Install-ChocolateyPackage @packageArgs
