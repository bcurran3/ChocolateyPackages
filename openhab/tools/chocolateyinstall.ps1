$ErrorActionPreference = 'Stop'
$packageName   = 'openhab' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\openhab-2.3.0.zip"
$checksum      = '32BD9A69AA629BFCA39134FE7AC1BC5701D8FF66CD18C61F56B3590598946670'
$ExeFile       = 'start.bat'
$ShortcutName  = 'openHAB.lnk'
$ShortcutName2 = 'openHAB Dashboard.lnk'
$ShortcutName3 = 'openHAB Configuration Folder.lnk'
$ShortcutName4 = 'openHAB Documentation.lnk'
$ShortcutName5 = 'openHAB Community.lnk'
$ShortcutName6 = 'openHAB Console.lnk'
$ShortcutName7 = 'openHAB Logs.lnk'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

New-Item "$toolsDir\openHAB" -type directory -force -ErrorAction SilentlyContinue
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\openHAB" -WorkingDirectory "$toolsDir\openHAB" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\openHAB" -WorkingDirectory "$toolsDir\openHAB" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName2" -targetPath "http://localhost:8080" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName3" -targetPath "$toolsDir\conf" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName4" -targetPath "http://docs.openhab.org/" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName5" -targetPath "https://community.openhab.org/" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName6" -targetPath "$toolsDir\runtime\bin\client.bat" -WorkingDirectory "$toolsDir\runtime\bin" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName7" -targetPath "$toolsDir\userdata\logs" -IconLocation "$toolsDir\openHAB.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
Remove-Item $url | Out-Null
