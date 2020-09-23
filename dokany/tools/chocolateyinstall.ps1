$ErrorActionPreference = 'Stop'
$packageName    = 'dokany'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\Dokan_x86.msi" 
$url64          = "$toolsDir\Dokan_x64.msi"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/passive /norestart'
  softwareName  = 'Dokan Library*'
}

Install-ChocolateyPackage @packageArgs
Remove-Item $url -Force -EA SilentlyContinue | Out-Null
Remove-Item $url64 -Force -EA SilentlyContinue | Out-Null
