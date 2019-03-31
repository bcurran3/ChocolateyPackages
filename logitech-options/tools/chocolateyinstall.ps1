$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\logitech-options_install.ahk"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/options/Options_7.12.43.exe'
$checksum = 'CC96E05BF0731AC149E59DE4F776BC0E16DE02BD2169359C36ABEB7427460D0F'

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
