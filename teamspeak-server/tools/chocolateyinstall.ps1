$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_win32-3.13.7.zip'
$checksum     = '03ec18e7700d0884d09e6cbb9419cc8ea80736bf5ac82582941bbe8dc81f3d52'
$url64        = 'https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_win64-3.13.7.zip'
$checksum64   = '489f6f02b336f80812ad0307897e072c37042d1c39341e4efbe7c09d1e100f59'
$shortcutName = 'TeamSpeak Server.lnk'
$exe          = 'ts3server.exe'

if ((Get-OSArchitectureWidth -Compare 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $workingDir = 'teamspeak3-server_win64'
    } else {
     $workingDir = 'teamspeak3-server_win32'
    }

$packageArgs = @{
  packageName    = 'teamspeak-server' 
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64 
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$workingDir\$exe" -WorkingDirectory "$toolsDir\$workingDir"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
