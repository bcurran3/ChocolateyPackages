$ErrorActionPreference = 'Stop'
$packageName    = 'utorrent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.utorrent.com/downloads/complete/track/stable/os/win'
$checksum       = '94F906A69CC3498BDEC87E6C8C4647484C41D4B52D4B7A062FB1FF6BFD8B795C'
$extractDir     = "$toolsDir\extracted"
$fileLocation   = "$extractDir\Carrier.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0,1)
  softwareName   = 'uTorrent*'
}
 
Start-CheckandStop "uTorrent"

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10
if ($ProcessWasRunning -eq "True") {$ProcessFullPath} else {Start-CheckandStop "uTorrent"}
Remove-Item $extractDir -Recurse | Out-Null
