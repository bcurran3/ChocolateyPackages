$packageName   = 'metafox'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\MetaFox_$env:ChocolateyPackageVersion.exe"

$packageArgs = @{
  packageName    = $packageName
  softwareName   = 'MetaFox*'  
  fileType       = 'EXE'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  
  file           = $url
  validExitCodes = @(0)  
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url | out-null