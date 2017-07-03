$packageName    = 'astromenace'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/openastromenace/1.3.2/astromenace-win-1.3.2.exe' 
$checksum       = '489C468EE094C98F9F827848BF5EC1C2094AE1BDD5F263A2B45339B40B1ACBBE'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'AstroMenace*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
