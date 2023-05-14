$ErrorActionPreference = 'Stop';
$packageName = 'sumo'
$url         = 'https://kcsoftwares.com/files/sumo_lite.exe'
$checksum    = '51CBCBE2A32E88D720661B3DA44A059E17581415EFBB813F1FC3EDF8BD007ECF'

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
