$ErrorActionPreference = 'Stop'
$packageName= 'opendns-updater'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.opendns.com/wp-content/uploads/2014/01/OpenDNS-Updater-2.2.1.exe' 
$silentArgs = '/S' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs 
  validExitCodes= $validExitCodes 
  softwareName  = 'OpenDNS Updater 2.2.1*'
  checksum      = 'F806B50836914731B1D5A5611B4F497191D097C58A728DD8129B29C7FB66FA25'
  checksumType  = 'sha256'  
}

Install-ChocolateyPackage @packageArgs
