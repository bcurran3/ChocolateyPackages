$ErrorActionPreference = 'Stop'
$packageName = 'osfmount' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits        = Get-ProcessorBits
$url         = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum    = '5348838DD60607057DBD1448E5173D1C4C6280B82AFE9967A837499822FC8C5D'

if ($bits -eq 32)
   {
	Write-Host "  ** OSFMount v3+ is 64 bit only. Please try v2. Aborting." -Foreground Red
	throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'OSFMount*' 
  }

Install-ChocolateyPackage @packageArgs
