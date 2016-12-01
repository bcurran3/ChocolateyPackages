$packageName   = 'pxe-boot-tool'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'http://www.aomeisoftware.com/download/pxe/PXEBoot.exe'
$checksum      = '982BB7FDF2AA85A0E233462B9B47F368AD7B4FD8ACACF8185C0B5C3B96286796'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'AOMEI PXE Boot Free*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

