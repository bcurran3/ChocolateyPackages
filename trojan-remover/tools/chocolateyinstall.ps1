$ErrorActionPreference = 'Stop'
$packageName    = 'trojan-remover'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://tremover.com/download/dl/trjsetup695.exe' 
$checksum       = '4AD54BAE9C94E565246ECE5C96FD504CB539C624F4EF2705EA71449FB151134B'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes
  softwareName  = 'Trojan Remover*'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
