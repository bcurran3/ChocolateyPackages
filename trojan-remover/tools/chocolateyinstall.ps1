$ErrorActionPreference = 'Stop'
$packageName    = 'trojan-remover'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://tremover.com/download/dl/trjsetup694.exe' 
$checksum       = '2BC762252105B34EAE04A6000CBEDA65874D93345BD533B8E0128877E6DDCB3C'
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
