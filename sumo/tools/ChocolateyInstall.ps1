$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\SUMo_Install.ahk"
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = 'F1805EC769607B9C8F565614B92025930E87024ED048EA799275243A48267F1E'

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)   
}

#Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "SUMo"  

# UPDATE INSTRUCTIONS:
# Update checksum