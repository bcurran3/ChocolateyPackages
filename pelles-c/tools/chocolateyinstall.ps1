$packageName    = 'pelles-c'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.smorgasbordet.com/pellesc/800/setup.exe' 
$checksum       = 'F2A236CFC8A62DA6B6A6CFE9B8A6E5230F9E052A01574649ABAB51E1CEF5A153'
$url64          = 'http://www.smorgasbordet.com/pellesc/800/setup64.exe' 
$checksum64     = '1E5AEFFAA499D8CE3A004866F6B9E3EB073887E9765AD381E76B3A11EBB637F6'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$bits           = Get-ProcessorBits

if ($bits -eq 64)
   {
    $ahkFile        = Join-Path $toolsDir "PellesCInstall64.ahk"
   } else {
    $ahkFile        = Join-Path $toolsDir "PellesCInstall32.ahk"
    }

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  url64         = $url64  
  softwareName  = 'Pelles C for Windows' 
  checksum      = $checksum
  checksum64    = $checksum64  
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
