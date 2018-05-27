$ErrorActionPreference = 'Stop'
$packageName    = 'trojan-remover'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://simplysup.co.uk/download/dl/trjsetup695.exe' 
$checksum       = '526B5C905B4EEB58457F029A5F3EFC8851E0566C457CB809C768C9A176041285'
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
