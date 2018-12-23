$ErrorActionPreference = 'Stop'
$packageName   = 'openhab' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\openhab-$env:ChocolateyPackageVersion.zip"
$checksum      = 'ABAA07133C4CBD1C2971CB75B64B7EEE930ABF270E997041B4DCCF9366BD89C2'
$ExeFile       = 'start.bat'
$ShortcutName  = 'openHAB.lnk'
$ShortcutName2 = 'openHAB Dashboard.lnk'
$ShortcutName3 = 'openHAB Configuration Folder.lnk'
$ShortcutName4 = 'openHAB Documentation.lnk'
$ShortcutName5 = 'openHAB Community.lnk'
$ShortcutName6 = 'openHAB Console.lnk'
$ShortcutName7 = 'openHAB Logs.lnk'

if (!($env:JAVA_HOME)) {
    Write-Warning "  ** JAVA_HOME enviromental variable not set. You should set this."
   } else {
    Write-Host "  ** JAVA_HOME is currently set to $env:JAVA_HOME" -ForeGround Magenta
   }

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
New-Item "$toolsDir\userdata\logs" -ItemType Directory 
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName7" -targetPath "$toolsDir\userdata\logs" -IconLocation "$toolsDir\openHAB.ico" 

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
Remove-Item $toolsDir\openhab-*.zip -Force | Out-Null
