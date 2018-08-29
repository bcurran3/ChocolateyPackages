$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\logitech-options_install.ahk"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/options/Options_6.92.275.exe'
$checksum = '061818E561F9C0B5CAFBD87A104E52B824D60CB9EF9982985BBA3C00D1B02F75'

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
