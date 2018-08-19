# This is an anti-pattern package: ChocolateyInstall UNinstalls OneDrive and ChocolateyUninstall installs OneDrive
$packageName = 'uninstall-onedrive-win10-winconfig'
$bits        = Get-ProcessorBits

# Windows 10
If (!(Get-IsWin10))
   {
    Write-Host "This package is for Windows 10 computers only." -foreground red
	throw
   }

if ($bits -eq 64)
   {
	"$env:SystemRoot\SysWOW64\OneDriveSetup.exe /uninstall"
   } else {
	"$env:SystemRoot\System32\OneDriveSetup.exe /uninstall"
   }
   
Get-Process "OneDrive" -ErrorAction SilentlyContinue | Stop-Process

New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -ea SilentlyContinue | Out-Null
Set-ItemProperty -LiteralPath "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name DisableFileSyncNGSC -Value 1 -ea SilentlyContinue
   
Remove-Item "$env:UserProfile\OneDrive" -recurse -ea SilentlyContinue
Remove-Item "$env:LocalAppData%\Microsoft\OneDrive" -recurse -ea SilentlyContinue
Remove-Item "$env:ProgramData%\Microsoft OneDrive" -recurse -ea SilentlyContinue
Remove-Item "$env:SystemDrive\OneDriveTemp" -recurse -ea SilentlyContinue
Remove-Item "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue 
Remove-Item "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue 
