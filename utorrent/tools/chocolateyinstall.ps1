$packageName    = 'utorrent'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum       = 'BCC95EECEFDA2240F3358AB9DE2C30D54B7F07C6704C78F1A6457AD1E9E1FF6D'
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
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = '/S'
  validExitCodes= @(0,1)
  softwareName  = 'uTorrent*'
}
 
Start-CheckandStop "uTorrent"

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10
if ($ProcessWasRunning -eq "True") {$ProcessFullPath} else {Start-CheckandStop "uTorrent"}

Remove-Item $extractDir -recurse | out-null
