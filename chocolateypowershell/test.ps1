$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$ENV:Public\Desktop\ChocolateyPowerShell.lnk")
$Shortcut.TargetPath = "$env:chocolateyinstall\choco.ico"
$Shortcut.Save()