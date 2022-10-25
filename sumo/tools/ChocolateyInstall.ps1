$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\SUMo_Install.ahk"
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = 'AEE75F5D6FCD511F3C2AA57DC1569B183A9859D34AAC352C6C3318DCFD8BD366'

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)   
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "SUMo"  
