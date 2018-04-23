$ErrorActionPreference = 'Stop'
$packageName = 'drobo-dashboard' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://files.drobo.com/webrelease/dashboard/Drobo-Dashboard-3.2.0.exe'
$checksum    = '5ECAC655CB6D5029F596F3C12C52184EEFBECDC80D0F7CC3E324748FBBDB35F6'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "DDinstall.ahk"

$Installed = (Test-Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{863885B3-7C05-421C-8817-568712778745}")
If ($Installed -eq "True")
    {
	Write-Host Found previous version of Drobo Dashboard. -ForegroundColor red -BackgroundColor blue
	Write-Host Attempting to uninstall it... -ForegroundColor red -BackgroundColor blue
	Start-Process -FilePath "msiexec.exe" -ArgumentList "/x {863885B3-7C05-421C-8817-568712778745} /qn"
	Start-Sleep -s 10
    }

Start-Process $ahkExe $ahkFile

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

Install-ChocolateyPackage @packageArgs
