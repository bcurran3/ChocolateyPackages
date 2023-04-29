$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '45D7A9A605239532D77A9BBB37268AA2279653B97B53360C335B7EFCBBBA4E7F'

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
