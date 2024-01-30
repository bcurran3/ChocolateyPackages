$packageName    = 'plex-home-theater'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\PlexHomeTheater-1.4.1.469-47a90f01-windows-x86.exe"
$checksum       = 'DFA9144CEDB77ECD62B001A4685EFA8EE2F9144217AF5DE9D0B3E8E90D63BE6D'
$checksumType   = 'sha256' 
$installerType  = 'exe'
$silentArgs     = '/S'
$validExitCodes = @(0,1)
$softwareName   = 'Plex Home Theater'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumType 
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$softwareName installed." "Version $env:packageVersion."
Remove-Item $url

