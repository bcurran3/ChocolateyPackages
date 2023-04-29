$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.exe'
$checksum = '3C9FD52B9BD3BFC1C3579904FD41DF575E30258660F9EFA8BD0FF425580A0AAF'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/quiet /update No'
    validExitCodes = @(0)   
}

Install-ChocolateyPackage @packageArgs
