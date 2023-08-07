$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = 'B96DAA8F84A6D2436B74C4A8318441FB17F5436F4F041A52CA0A95B1C8251BC4'

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
