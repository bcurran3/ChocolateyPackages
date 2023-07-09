$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '004BD05F6BA9A9D0BEE2BDBDCF498A1D18DB559CB58E28998D4061FBAFB64D97'

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
