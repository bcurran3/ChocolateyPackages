$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation = "$toolsDir\wslfiles"
$shortcutName  = 'WSL Ubuntu 16.04.lnk'
$exe           = 'ubuntu1604.exe'
$appx          = 'Ubuntu_1604.2019.523.0_x64.appx'

$Upgrade = ((Test-Path "$ENV:ChocolateyInstall\lib\wsl-ubuntu-1604\tools\wslfiles\ubuntu1604.exe") -or (Test-Path "$ENV:ChocolateyInstall\lib\wsl-ubuntu-1604\tools\wslfiles\ubuntu.exe"))

if ($Upgrade){
    Write-Host "  ** Existing version of Ubuntu 16.04 found." -Foreground Magenta
    Write-Host "  ** Upgrading packages." -Foreground Magenta
	ubuntu1604 run apt update
	ubuntu1604 run apt upgrade -y
    return
}

Write-Host "  ** Unzipping files. ""Maxima enim, patientia virtus."" (Look it up, you've got time.)" -Foreground Magenta
Get-ChocolateyUnzip -FileFullPath "$toolsDir\$appx" -Destination "$toolsDir\wslfiles"
Get-ChocolateyUnzip -FileFullPath "$toolsDir\wslfiles\install.tar.gz" -Destination "$toolsDir\wslfiles"
Get-ChocolateyUnzip -FileFullPath "$toolsDir\wslfiles\install.tar" -Destination "$toolsDir\wslfiles"

$packageArgs = @{
  packageName    = 'wsl-ubuntu-1604'
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'  
  file           = "$toolsDir\wslfiles\$exe"
  validExitCodes = @(0,1)
 }
Install-ChocolateyInstallPackage @packageArgs

ubuntu1604 run lsb_release -a

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\wslfiles\$exe" -WorkingDirectory "$toolsDir\wslfiles"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\wslfiles\$exe" -WorkingDirectory "$toolsDir\wslfiles"

Remove-Item "$toolsDir\*.appx" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\*.gz" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\*.pri" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\*.tar" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\wslfiles\*.xml" -Force -EA SilentlyContinue | Out-Null

$WhoAmI=whoami
icacls.exe "$toolsDir\wslfiles" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

wslconfig /list
Write-Host "  ** To run Ubuntu 16.04, type ""ubuntu1604"" from your CLI." -Foreground Magenta
