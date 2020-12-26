$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\SUMo_Install.ahk"
$url         = 'https://www.kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '3422E1C8342E17D5C2E12B99420D66063E5086AE756F053B075F437CA06ABE28'

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
