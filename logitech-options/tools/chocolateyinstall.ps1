$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe'
$checksum = '59C16CFFE04EA4BBFF1B1A38E49AE99135591F72D87153FAC463927586F96E71'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/quiet /norestart'
    validExitCodes = @(0)   
}

Install-ChocolateyPackage @packageArgs
