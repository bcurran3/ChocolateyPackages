$packageName    = 'pytivo-desktop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.pytivodesktop.com/win32/pyTivo_1.6.16.exe'
$checksum       = '7527157B7CB6B0F6D5D03FCB8075EE7E2B1EA73A274A6BFED87E21A158C1A13C'
$validExitCodes = @(0)
$bits           = Get-ProcessorBits
$shortcutName   = 'pyTivo.lnk'
$exe            = "pyTivoTray.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "PDInstall.ahk"

if((get-process "PyTivoTray" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivoTray currently NOT running." -foreground green
  }else{ 
    Write-Host "Stopping PyTivoTray process(es)..." -foreground yellow
    Stop-Process -processname PyTivoTray -force
	$PyTivoTrayWasRunning="True"
  }

if((get-process "PyTivo" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivo currently NOT running." -foreground green
  }else{ 
    Write-Host "Stopping PyTivo process(es)..." -foreground yellow
    Stop-Process -processname PyTivo -force
  }

if((get-process "PyTivoDesktop" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "PyTivoDesktop currently NOT running." -foreground green
  }else{ 
    Write-Host "Stopping PyTivoDesktop process(es)..." -foreground yellow
    Stop-Process -processname PyTivoDesktop -force
  }
  
Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '' 
  validExitCodes = $validExitCodes
  softwareName   = 'pyTivo' 
  checksum       = $checksum
  checksumType   = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

if ($bits -eq 64)
   {
     $exePath  = join-path "${env:ProgramFiles(x86)}" "\pyTivo"
    } else {
     $exePath  = join-path "${env:ProgramFiles}" "\pyTivo"
    }
	  
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$exePath\$exe" -WorkingDirectory "$exePath"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$exePath\$exe" -WorkingDirectory "$exePath"

# Below for when AHK script gets updated to handle upgrades
#if ($PyTivoTrayWasRunning="True") {
#start "$exePath\$exe"
#}
