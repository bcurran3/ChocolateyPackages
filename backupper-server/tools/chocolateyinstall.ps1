$packageName    = 'backupper-server'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType  = 'EXE'
$url            = 'http://www.aomeisoftware.com/download/adb/ABServer.exe'
$checksum       = 'C9369853EB6F138E800575D60A62AFE6C1DD513744D6CA3B452C53A365B43925'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0,1)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "BUInstall.ahk"
$ServerOS       = (Get-WmiObject -class Win32_OperatingSystem).Caption
$Answer         = $ServerOS -match "Server"

if ($Answer -ne "True")
   {
    Write-Host "This package is for Windows Server OSes only. Aborting." -foreground red -backgroundcolor blue
	throw
   }

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  softwareName  = 'AOMEI Backupper Server*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes  
  }
Install-ChocolateyPackage @packageArgs

