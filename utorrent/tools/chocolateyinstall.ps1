$ErrorActionPreference = 'Stop'
$packageName  = 'utorrent'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://download-hr.utorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum     = '583DE3E54F2BFBB945BB548D59C4CA3E691782C63623BF4297DFF545436EE0A0'
$extractDir   = "$toolsDir\extracted"
$fileLocation = "$extractDir\Carrier.exe"

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
Remove-Item "$extractDir" -Recurse -ErrorAction SilentlyContinue | Out-Null
