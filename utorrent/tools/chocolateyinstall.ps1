$ErrorActionPreference = 'Stop'
$packageName    = 'utorrent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum       = '36392BBA8E031CCBD17BBAC298947E1A62A29BA10DABDFF08E4773A23CECBDD0'
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
