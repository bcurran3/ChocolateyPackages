$packageName  = 'teamspeak-server' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://dl.4players.de/ts/releases/3.2.0/teamspeak3-server_win32-3.2.0.zip'
$checksum     = '76079F8D70EC3ABFDA454F468F7498B2134A30B9846D4CB4BFE179E19BCCDDDE'
$url64        = 'http://dl.4players.de/ts/releases/3.2.0/teamspeak3-server_win64-3.2.0.zip'
$checksum64   = '5E14BB358B9367E0597F4D4D00C7F1E9F60E88973DAA2C8EC43A11AD1612A046'
$shortcutName = 'TeamSpeak Server.lnk'
$exe          = 'ts3server.exe'

if ((Get-OSArchitectureWidth -eq 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $workingDir = 'teamspeak3-server_win64'
    } else {
     $workingDir = 'teamspeak3-server_win32'
    }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64 
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyZipPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null