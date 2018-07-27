$ErrorActionPreference = 'Stop'

$arguments = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'MetaX for Windows'
    url            = 'https://www.danhinsley.com/downloads/MetaXSetup.msi'
    checksum       = '186AFD435DCB49528943F68EF59E66A74CF040A0BFA23C6FCE480DE721A6DE03'
    fileType       = 'msi'
    checksumType   = 'sha256'
    silentArgs     = '/quiet'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
