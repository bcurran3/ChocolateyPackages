$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe      = 'AutoHotKey'
$url         = 'https://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.4.2.exe'
$checksum    = 'D4EC8605FF4CF3C6A6532EFA14AD7CBE086CAB16E39C831EB149F18FC8AB85CD'


$PreviouslyInstalled = (Test-Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{863885B3-7C05-421C-8817-568712778745}")
If ($PreviouslyInstalled -eq $True){
	Write-Host " ** Uninstalling previous version of Drobo Dashboard" -ForegroundColor Magenta
	Start-CheckandStop "Drobo Dashboard"
	Start-CheckandStop "DDAssist"

    $packageArgs = @{
      packageName   = $packageName
      fileType      = 'MSI' 
      silentArgs    = '{863885B3-7C05-421C-8817-568712778745}'
      softwareName  = 'Drobo Dashboard' 
    }

    $ahkFile = "$toolsDir\drobo-dashboard_uninstall.ahk" 
    Start-Process $ahkExe $ahkFile 
    Uninstall-ChocolateyPackage @packageArgs
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'Drobo Dashboard' 
  }

$ahkFile = "$toolsDir\drobo-dashboard_install.ahk"
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

If ($PreviouslyInstalled -eq $True){
   if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
   }
