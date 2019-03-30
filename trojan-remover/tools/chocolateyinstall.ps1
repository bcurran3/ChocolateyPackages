$ErrorActionPreference = 'Stop'
$packageName    = 'trojan-remover'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://simplysup.co.uk/download/dl/trjsetup695.exe' 
$checksum       = '3DEF7DE5A01E9649CE818C5CF2AA91F6CA1829DFE09128BBC2E266E5D6BE85AB'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url            = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'   
  validExitCodes = @(0) 
  softwareName   = 'Trojan Remover*'
  checksum       = $checksum
  checksumType   = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
