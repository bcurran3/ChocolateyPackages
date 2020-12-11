$packageName= 'godmode' 
$desktop=[Environment]::GetFolderPath("Desktop")
if (!(Test-Path "$desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}")) {md "$desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" | Out-Null}
