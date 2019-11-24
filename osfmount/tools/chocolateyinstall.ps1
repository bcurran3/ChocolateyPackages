$ErrorActionPreference = 'Stop'
$packageName = 'osfmount' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file64         = "$toolsDir\osfmount.exe"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  validExitCodes = @(0,1)
  softwareName   = 'OSFMount*' 
}
 
Install-ChocolateyInstallPackage @packageArgs

Start-CheckandStop "OSFMount"  
Remove-Item "$toolsDir\*.exe" -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.ignore" -ErrorAction SilentlyContinue | Out-Null
