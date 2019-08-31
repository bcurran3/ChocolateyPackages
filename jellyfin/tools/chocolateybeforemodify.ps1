$ErrorActionPreference = 'Stop'
$packageName  = 'jellyfin'
$Date         = Get-Date -UFormat %Y-%m-%d
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Start-CheckandStop "jellyfin"
if (Test-Path "$toolsDir\jellyfin") {
    Rename-Item -Path "$toolsDir\jellyfin" -NewName "$toolsDir\jellyfin.old.$Date"
    Write-Host "" | Out-File "$toolsDir\jellyfin.old.$Date\ffmpeg.exe.ignore"
    Write-Host "" | Out-File "$toolsDir\jellyfin.old.$Date\ffprobe.exe.ignore"
    Write-Host "" | Out-File "$toolsDir\jellyfin.old.$Date\nssm.exe.ignore"
	Write-Host "" | Out-File "$toolsDir\jellyfin.old.$Date\jellyfin.exe.ignore"
	}
