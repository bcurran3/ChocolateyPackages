$ErrorActionPreference = 'Stop'
$packageName    = 'pytivo-desktop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\PDInstall.ahk"
$url            = 'https://www.pytivodesktop.com/win32/pyTivo_1.6.22.exe'
$checksum       = '29E15B516614E5F457C8C27DFBDCBE5D24620E0B9E4656BC28B4C800768E729C'

if((get-process "PyTivoTray" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivoTray currently NOT running." 
  }else{ 
    Write-Host "Stopping PyTivoTray process(es)..."
    Stop-Process -processname PyTivoTray -force
  }


if((get-process "PyTivo" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivo currently NOT running." 
  }else{ 
    Write-Host "Stopping PyTivo process(es)..."
    Stop-Process -processname PyTivo -force
  }

if((get-process "PyTivoDesktop" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivoDesktop currently NOT running." 
  }else{ 
    Write-Host "Stopping PyTivoDesktop process(es)..."
    Stop-Process -processname PyTivoDesktop -force
  }

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '' 
  validExitCodes = @(0)
  softwareName   = 'pyTivo' 
  checksum       = $checksum
  checksumType   = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

$exe  = "pyTivoTray.exe"

if ($bits -eq 64)
   {
     $exePath  = join-path "${env:ProgramFiles(x86)}" "\pyTivo"
    } else {
     $exePath  = join-path "${env:ProgramFiles}" "\pyTivo"
    }
	  
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\pyTivo.lnk" -targetPath "$exePath\$exe" -WorkingDirectory "$exePath"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\pyTivo.lnk" -targetPath "$exePath\$exe" -WorkingDirectory "$exePath"
