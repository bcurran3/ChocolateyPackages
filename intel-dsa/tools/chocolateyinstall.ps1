$packageName    = 'intel-dsa'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20and%20Support%20Assistant%20Installer.exe'
$checksum       = 'F6938A3275E2A343CC883261BC94E154EA40D19E81D9E8D7AD31E907CD4F50FF'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '/S'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "DSAinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel® Driver & Support Assistant'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
