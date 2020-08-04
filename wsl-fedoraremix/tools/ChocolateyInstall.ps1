$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-fedoraremix'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName   = 'Fedora Remix.lnk'
$exe            = "$toolsDir\distro\fedoraremix.exe"

$Upgrade = (Test-Path "$ENV:ChocolateyInstall\lib\$packageName\tools\distro\fedoraremix.exe")

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

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\distro"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_" + "$ENV:ChocolateyPackageVersion" + "_x64.appx"
}

Install-ChocolateyZipPackage @packageArgs

if ($Upgrade){
    Write-Host "  ** Existing version of Fedora Remix found." -Foreground Magenta
    Write-Host "  ** Upgrading launcher and system packages." -Foreground Magenta
	fedoraremix run dnf upgrade-minimal
    Write-Host "  ** Run ""dnf upgrade"" inside Fedora Remix to upgrade all packages." -Foreground Magenta
    Delete-UnnecessaryFiles
    return
}

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'  
  file           = "$toolsDir\distro\fedoraremix.exe"
  validExitCodes = @(0,1)
 }
#Install-ChocolateyInstallPackage @packageArgs v1.30.1.0 appears to be broken

Get-ChocolateyUnzip -FileFullPath "$toolsDir\distro\install.tar.gz" -Destination "$toolsDir\distro"
Get-ChocolateyUnzip -FileFullPath "$toolsDir\distro\install.tar" -Destination "$toolsDir\distro\rootfs"

Install-BinFile -Name fedoraremix -Path $exe
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"

wslconfig /list
Write-Host "  ** To run Fedora Remix, type ""fedoraremix"" from your CLI." -Foreground Magenta

# wait for installer to finish extracting files
    $LoopMePlease=0
    while (!(Test-Path "$ENV:ChocolateyInstall\lib\wsl-fedoraremix\tools\distro\rootfs\var\yp")){
	       if ($LoopMePlease -eq 0) {Write-Host "  ** Waiting for files to finish extracting" -NoNewLine -Foreground Magenta}
		   Write-Host "." -NoNewLine -Foreground Magenta
           Start-Sleep -Seconds 10
		   $LoopMePlease++
# break out of the loop after 10 minutes in case of error
		   if ($LoopMePlease -gt 60) {
	          Write-Warning "`nSomething went wrong with extracting the rootfs distro files."
			  wslconfig /list
		      throw
			 } 
          }

Delete-UnnecessaryFiles
$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
