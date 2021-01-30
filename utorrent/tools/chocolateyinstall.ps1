$ErrorActionPreference = 'Stop'
$packageName  = 'utorrent'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://download-hr.utorrent.com/track/stable/endpoint/utorrent/os/windows'
$checksum     = 'C1EC45E575687AD3F37BD7C8679EEFBE94A90A6873CD4050D581FA97AF8ED9BC'
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
