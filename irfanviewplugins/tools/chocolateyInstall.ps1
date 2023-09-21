$ErrorActionPreference = 'Stop'
$packageName    = 'irfanviewplugins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file           = "$(Get-ChildItem $toolsDir\*_setup.exe -Exclude *x64*.exe)"
$file64         = "$(Get-ChildItem $toolsDir\*_setup.exe -Include *x64*.exe)"

if ($env:chocolateyForceX86){$file64 = $file}

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$file"
  file64         = "$file64"
  validExitCodes = @(0)
  silentArgs     = '/silent'
  softwareName   = ''
}

Install-ChocolateyInstallPackage @packageArgs  

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace binaries
