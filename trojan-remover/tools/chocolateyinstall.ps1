$ErrorActionPreference = 'Stop'
$packageName    = 'trojan-remover'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://tremover.com/download/dl/trjsetup694.exe' 
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
  checksum      = '45077CA86B1B528AF7A65877A9431BC93957778E9BB472E0E5226D0CC84871C4'
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
