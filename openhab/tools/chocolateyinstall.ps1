$ErrorActionPreference = 'Stop'
$packageName  = 'openhab' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F2.2.0%2Fopenhab-2.2.0.zip'
$checksum     = '1C57555BECABF3D5BCBE7A4CE10183271DBC2B0F6954E987506D46D0CA3072FC'
$url2         = 'https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab-addons%2F2.2.0%2Fopenhab-addons-2.2.0.kar'
$checksum2    = 'A7E6E8251489E64C22402973B550AA5436E8A23C38AB143E15A287BD32494206'
$ExeFile      = 'start.bat'
$ShortcutName = 'openHAB'
$fileName     = 'openhab-addons-2.2.0.kar'
$FileFullpath = '$ToolsDir\addons\$fileName'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = ''
  url           = $url2
  FileFullPath  = $FileFullpath
  checksum      = $checksum2
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir" -IconLocation "$toolsDir\openHAB.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
