$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\SUMo_Install.ahk"
$url         = 'https://www.kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '686145D0B1C35DFEE3E1E9F2D219DCF7C7A085D8E615EC00895BE516EA6B828A'

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checkum        = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)   
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "SUMo"  
