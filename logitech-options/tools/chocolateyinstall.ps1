$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\logitech-options_install.ahk"
$url      = "https://download01.logi.com/web/ftp/pub/techsupport/options/Options_$env:ChocolateyPackageVersion.exe"
$checksum = '877A13AE7698CF7DE444C501967C909C1AD8E60C696C9CF37B5752D11B741927'

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
