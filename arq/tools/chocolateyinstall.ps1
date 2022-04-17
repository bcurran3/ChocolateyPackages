$ErrorActionPreference = 'Stop'
$packageName = 'arq'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.arqbackup.com/download/arqbackup/Arq7.msi'
$checksum = 'b02785d09daef0f3783cda7a070113397baf586b9a246567120c29d4365a1b9a'

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
