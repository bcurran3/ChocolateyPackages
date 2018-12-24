$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$url = "$toolsDir\OpenShellSetup_4_4_131.exe"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = $url
  softwareName   = 'Open-Shell'
  silentArgs     = '/passive'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $url -Force -EA SilentlyContinue | Out-Null
