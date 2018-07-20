$packageName = 'tcc'
$global:packageMaintainer = 'BCURRAN3'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType    = 'exe'
$silentArgs  = '/quiet'
$url         = 'https://jpsoft.com/downloads/v23/tcc.exe'
$checksum    = '0DD270CAABE9F0CA0447D5603B355D57955387818126290057AF1B2D885CB567'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'TCC 23' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."