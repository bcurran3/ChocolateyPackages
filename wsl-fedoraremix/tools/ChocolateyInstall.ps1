$ErrorActionPreference = 'Stop'
# https://github.com/WhitewaterFoundry/Fedora-Remix-for-WSL/releases/
$packageName  = 'wsl-fedoraremix'
$bits         = Get-ProcessorBits
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'WSL Fedora Remix.lnk'
$exe          = "$toolsDir\distro\fedoraremix.exe"
$appx         = 'Fedora-Remix-for-WSL_1.31.21.0_x64.appx'

if (!($bits -eq 64)){
    Write-Host "  **  This package is for 64 bit versions of Windows only. Aborting..." -Foreground Red
	throw
	}

function Delete-UnnecessaryFiles{
 Remove-Item "$toolsDir\*.appx" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.gz" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.p7x" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.pri" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.tar" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.xml" -Force -EA SilentlyContinue | Out-Null
}

$Upgrade = (Test-Path "$ENV:ChocolateyInstall\lib\$packageName\tools\distro\fedoraremix.exe")

if ($Upgrade){
    Write-Host "  ** Existing version of Fedora Remix found." -Foreground Magenta
    Write-Host "  ** Upgrading launcher and system packages." -Foreground Magenta
	fedoraremix run dnf upgrade-minimal
    Write-Host "  ** Run ""dnf upgrade"" inside Fedora Remix to upgrade all packages." -Foreground Magenta
    Delete-UnnecessaryFiles
    return
}

Get-ChocolateyUnzip -FileFullPath "$toolsDir\$appx" -Destination "$toolsDir\distro"
Move-Item "$toolsDir\distro\DistroLauncher\fedoraremix.exe" -Destination "$toolsDir\distro"

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'  
  file           = "$toolsDir\distro\fedoraremix.exe"
  validExitCodes = @(0,1)
 }
Install-ChocolateyInstallPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"

wslconfig /list
Write-Host "  ** To run Fedora Remix, type ""fedoraremix"" from your CLI." -Foreground Magenta

Delete-UnnecessaryFiles
$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
