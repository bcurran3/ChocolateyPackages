$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '614158AE45025E2AC13A043C78D3A8147543D6EFC6B51368182051100687B203'

$packageArgs = @{
    packageName    = $packageName
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    fileType       = 'EXE'
    silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes = @(0)
}

Start-CheckandStop "SUMo"
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "SUMo"

# UPDATE INSTRUCTIONS:
# Update checksum
