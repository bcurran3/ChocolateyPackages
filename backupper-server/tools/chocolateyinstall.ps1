$packageName   = 'backupper-server'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'EXE'
$url           = 'http://www.aomeisoftware.com/download/adb/ABServer.exe'
$checksum      = '814EF78059AA36C6A52DA179B1F73EB5EFD3932C1ABFC03E7B97D33B52E1A84F'
$silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0,1)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "BUInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  softwareName  = 'AOMEI Backupper Server*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes  
  }
Install-ChocolateyPackage @packageArgs

