$ErrorActionPreference = 'Stop'
$packageName= 'dell-update' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.dell.com/FOLDER03738438M/1/Application_75FF5_WN32_1.9.5.0_A10.EXE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = '57fe03d54dba7ad3594dd2296d61758310b545c1e8d5a67cc88b38ebb1b4f585'
  checksumType  = 'sha256'
  silentArgs   = '/S' 
  softwareName  = 'Dell Update*' 
}

Install-ChocolateyPackage @packageArgs
