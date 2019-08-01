$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe   = 'AutoHotKey'
$ahkFile  = "$toolsDir\unifying-fut_install.ahk"
$url      = 'https://aws13-customer-care-assets.s3.amazonaws.com/Software/SecureDFU/Win/SecureDFU_48.exe'
$checksum = 'D0E7DF9F19AC7DD2BA3976995ED2461C5DC296D0E5DCB65C17DAD46AACAD44C0'

$packageArgs = @{
    packageName    = $ENV:ChocolateyPackageName
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = ''
    validExitCodes = @(0)   
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
