$packageName    = 'rdpguard'
$installerType  = 'exe'
$url            = 'https://rdpguard.com/download/rdpguard-5-2-3.exe'
$checksum       = '4C009A6362FF29CA950D68EF2B40CFEF9131727744C3E065D749D0DFA631795F'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'RdpGuard*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
