$ErrorActionPreference = 'Stop'
$url      = 'https://www.danhinsley.com/downloads/MetaXSetup.msi'
$checksum = '13D60996BF0C3EE78F03223DBE781CB50204BEE84FC7741F0ACF22D3978FFAE0'

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
