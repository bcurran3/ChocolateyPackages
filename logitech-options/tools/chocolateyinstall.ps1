$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\logitech-options_install.ahk"
$url      = "https://download01.logi.com/web/ftp/pub/techsupport/options/Options_$env:ChocolateyPackageVersion.exe"
$checksum = '746C52C46C9E57D2C20922A4D9C5E11A1847AC24916A59ABFBC528235A356946'

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
