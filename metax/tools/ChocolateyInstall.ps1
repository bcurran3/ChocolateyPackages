$ErrorActionPreference = 'Stop'
$url      = 'https://www.danhinsley.com/downloads/MetaXSetup.msi'
$checksum = '8B45303132C9F491B8EC2F97369F1B281F194BB1AC3167782D4045162B9979E7'

$arguments = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'MetaX for Windows'
    fileType       = 'MSI'
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    silentArgs     = '/quiet'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
