$packageName    = 'utorrent'
$installerType  = 'exe'
$url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum       = 'EF2CF9A460373CB20EEDBC600DA0926F74EAFEE3185873B175B6E3B4FA075376'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'uTorrent*'
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
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Start-CheckandStop "uTorrent"

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10
if ($ProcessWasRunning -eq "True") {$ProcessFullPath} else {Start-CheckandStop "uTorrent"}

Remove-Item $extractDir -recurse | out-null  