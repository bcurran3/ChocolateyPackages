$packageName    = 'rocketdock'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\RocketDock-v1.3.5.exe"
$checksum       = '43759B0C441FD4F71FE5EEB69F548CD2EB40AC0ABFA02EA3AFC44FBDDF28DC16'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'RocketDock*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyPackage @packageArgs 
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."