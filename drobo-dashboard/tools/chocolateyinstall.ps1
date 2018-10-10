$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$PreviouslyInstalled = (Test-Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{863885B3-7C05-421C-8817-568712778745}")
$ahkExe      = 'AutoHotKey'
$url         = 'http://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.3.0.exe'
$checksum    = 'A858A0EF5CB7731AF31954E6B04BCB3C237A74C3C469DEE7A69D8E9C35836489'

If ($PreviouslyInstalled -eq $True){
	Write-Host " ** Uninstalling previous version of Drobo Dashboard" -ForegroundColor magenta
	Start-CheckandStop "DDAssist"
	Start-CheckandStop "Drobo Dashboard"

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
