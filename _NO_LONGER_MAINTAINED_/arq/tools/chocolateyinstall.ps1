$ErrorActionPreference = 'Stop'
$packageName = 'arq'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.arqbackup.com/download/arqbackup/Arq7.msi'
$checksum = '2eaba8af024a3c238946a268504dc55ca5986b6021461fbc58be70c4cde2ba23'

$packageArgs = @{
    packageName    = $packageName
    fileType       = 'MSI'
    url            = $url
    validExitCodes = @(0, 3010, 1641)
    silentArgs     = '/quiet /norestart'
    softwareName   = ''
    checksum       = $checksum
    checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs
