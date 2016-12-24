$ErrorActionPreference = 'Stop'
$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.dell.com/FOLDER03951264M/2/Application_TRR3F_WN32_1.9.7.0_A00.EXE'
$checksum   = 'CB5867FE403AE6B8E902EEA444B4BF0B186BC6C7FBC84C171734EAC7255B2796'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/S' 
  softwareName  = 'Dell Update*' 
}

Install-ChocolateyPackage @packageArgs
