$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\logitech-options_install.ahk"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe'
$checksum = '524934E0D0DAAA572AB7A43D15BF619FE2E864A2D46EE12A6BE71F4F319F56DC'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/S'
    validExitCodes = @(0)   
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-WaitandStop "LogiOptionsUI"
Start-CheckandStop "AutoHotkey"
