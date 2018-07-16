$ErrorActionPreference = 'Stop'
$packageName  = 'atomicparsley' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = "$toolsDir\AtomicParsley-win32-0.9.0.zip"
$checksum     = 'F363630462EA01D7DE948C3E4D231159FA91916D8D7F971A7E8B3BC478DBE846'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Remove-Item "$toolsDir\AtomicParsley-win32-0.9.0.zip"
# delete MacOS stuff
Remove-Item "$toolsDir\AtomicParsley-win32-0.9.0\.DS_Store"
Remove-Item "$toolsDir\__MACOSX" -recurse | out-null

