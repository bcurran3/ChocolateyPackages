$packageName   = 'intel-driver-update-utility'
$installerType = 'exe'
$url           = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20Update%20Utility%20Installer.exe'
$checksum      = '613D5F632AAE16CA7351781EE555AA5B57BBC76790B85C0C93511F9BF9470DFE'
$toolsDir      = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs    = '-norestart -silent'
$validExitCodes= @(0)

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "DUUinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel® Driver Update Utility*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
