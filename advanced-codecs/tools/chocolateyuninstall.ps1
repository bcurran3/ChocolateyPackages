$packageName    = 'advanced-codecs'
$softwareName   = 'Shark007 ADVANCED Codecs*'

Start-Process -FilePath "msiexec.exe" -ArgumentList "/x {8C0CAA7A-3272-4991-A808-2C7559DE3409} /qn"
Start-Process -FilePath "$env:ProgramFiles\Shark007\unins000.exe" -ArgumentList "/SILENT"
return

#below for future use

$packageArgs = @{
  packageName    = $packageName
  FileType       = 'MSI' 
  SilentArgs     = '/x {8C0CAA7A-3272-4991-A808-2C7559DE3409} /qn'
  ValidExitCodes = @(0)
  File           = 'msiexec.exe'
}
Uninstall-ChocolateyPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  FileType       = 'EXE' 
  SilentArgs     = '/SILENT'
  ValidExitCodes = @(0)
  File           = "$env:ProgramFiles\Shark007\unins000.exe"
}
Uninstall-ChocolateyPackage @packageArgs
