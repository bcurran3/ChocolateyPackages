<<<<<<< HEAD
﻿$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-fedoraremix'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$shortcutName   = 'Fedora Remix.lnk'
$exe            = "$toolsDir\distro\fedoraremix.exe"

if (!($bits -eq 64)){
    Write-Warning "  **  This package is for 64 bit versions of Windows only. Aborting..."
	throw
	}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appxbundle"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\distro"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appx"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$toolsDir\distro\fedoraremix.exe"
  validExitCodes = @(0,1)
  }

Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name fedoraremix -Path $exe
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"

wslconfig /list
Write-Host "  ** To run Fedora Remix, type fedoraremix from the Command Prompt or PowerShell." -ForeGround Magenta

# wait for installer to finish extracting files
    $LoopMePlease=0
    while (!(Test-Path "$ENV:ChocolateyInstall\lib\wsl-fedoraremix\tools\distro\rootfs\var\yp")){
	       Write-Host "  ** Waiting for files to finish extracting..." -ForeGround Magenta
           Start-Sleep -Seconds 10
		   $LoopMePlease++
# break out of the loop after 10 minutes in case of error
		   if ($LoopMePlease -gt 60) {
	          Write-Warning "Something went wrong with extracting the rootfs distro files."
			  wslconfig /list
		      break
			 } 
          }

$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

Remove-Item "$toolsDir\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appx" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appxbundle" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.xml" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.pri" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.xml" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.gz" -Force -EA SilentlyContinue | Out-Null
=======
﻿$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-fedoraremix'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$shortcutName   = 'Fedora Remix.lnk'
$exe            = "$toolsDir\distro\fedoraremix.exe"

if (!($bits -eq 64)){
    Write-Warning "  **  This package is for 64 bit versions of Windows only. Aborting..."
	throw
	}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appxbundle"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = "$toolsDir\distro"
  fileType       = 'ZIP' 
  url            = "$toolsDir\DistroLauncher-Appx_1.0.26.0_x64.appx"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$toolsDir\distro\fedoraremix.exe"
  validExitCodes = @(0,1)
  }

Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name fedoraremix -Path $exe
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"

wslconfig /list
Write-Host "  ** To run Fedora Remix, type fedoraremix from the Command Prompt or PowerShell." -ForeGround Magenta

# wait for installer to finish extracting files
    $LoopMePlease=0
    while (!(Test-Path "$ENV:ChocolateyInstall\lib\wsl-fedoraremix\tools\distro\rootfs\var\yp")){
	       Write-Host "  ** Waiting for files to finish extracting..." -ForeGround Magenta
           Start-Sleep -Seconds 10
		   $LoopMePlease++
# break out of the loop after 10 minutes in case of error
		   if ($LoopMePlease -gt 60) {
	          Write-Warning "Something went wrong with extracting the rootfs distro files."
			  wslconfig /list
		      break
			 } 
          }

$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

Remove-Item "$toolsDir\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appx" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.appxbundle" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\*.xml" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.p7x" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.pri" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.xml" -Force -EA SilentlyContinue | Out-Null
Remove-Item "$toolsDir\distro\*.gz" -Force -EA SilentlyContinue | Out-Null
>>>>>>> 569b2d7294411478d2ee52bfb07a69a9f3a90929
