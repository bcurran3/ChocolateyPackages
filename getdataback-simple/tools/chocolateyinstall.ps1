$packageName    = 'getdataback-simple'
$installerType  = 'exe'
$url            = 'http://www.runtime.org/gdbsimsetup.exe'
$checksum       = 'A7C32A5AFACF7D13D98321502E4964E7A357B6C2BF6E97B40CC69AC240896DD6'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'GetDataBack*'

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
