$packageName    = 'performancetest'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.passmark.com/ftp/petst.exe'
$checksum       = 'E8C56CBC306A388A4E0E49DD03CD5276079B75E7B3A9EFA621E92FFEEBD849E2'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0)
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'PerformanceTest*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
