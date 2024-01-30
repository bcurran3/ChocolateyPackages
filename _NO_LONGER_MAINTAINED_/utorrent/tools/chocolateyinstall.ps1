$ErrorActionPreference = 'Stop'
$packageName  = 'utorrent'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://download-hr.utorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum     = '41B0EBFE8BD3341B87E354C8CE536FEBD589C00019267F3D40D10E5F44FFC2D7'
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
