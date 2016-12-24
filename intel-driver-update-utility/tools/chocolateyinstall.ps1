$packageName = 'intel-driver-update-utility'
$installerType = 'exe'
$url = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20Update%20Utility%20Installer.exe'
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs = '-norestart -silent'
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
  checksum      = 'C747911C465E860A23C0CB5E9CC76946C5FFB2892DF07A178247C92F7C7B0F66'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
