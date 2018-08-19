# This is an anti-pattern package: ChocolateyInstall UNinstalls OneDrive and ChocolateyUninstall installs OneDrive
$packageName = 'uninstall-onedrive-win10-winconfig'
$bits        = Get-ProcessorBits

Set-ItemProperty -LiteralPath "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name DisableFileSyncNGSC -Value 0 -ea SilentlyContinue

if ($bits -eq 64)
   {
	"$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
   } else {
	"$env:SystemRoot\System32\OneDriveSetup.exe"
   }