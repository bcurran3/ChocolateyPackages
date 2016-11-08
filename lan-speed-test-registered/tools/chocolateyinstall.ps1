$packageName    = 'lan-speed-test-registered'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://totusoft.com/files/LAN_SpeedTest_Setup.exe'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'LAN Speed Test*'
  checksum      = '884CFCC9AD802C84E78E4928442519EE570A44AAE40464E3CEE866B24651E601'
  checksumType  = 'sha256'  
}

Install-ChocolateyPackage @packageArgs

















