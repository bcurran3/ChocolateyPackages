$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.1113-Windows-32bit.exe'
$checksum       = '50B497BDAB8CC35E5063B40D76A58EEF28B18844640B01F205F7056D7F0FF61F'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.1113-Windows-64bit.exe'
$checksum64     = '9A6C072C7A54ADFCEFFDB0F6E33187E42983992C9A6CEA79D95F4736DE4C9F1B'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.17.1113-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.17.1113-Windows-64bit.exe'

if ((Get-OSArchitectureWidth -eq 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $FileFullpath = "$ToolsDir\$fileName64"
    } else {
     $FileFullpath = "$ToolsDir\$fileName32"
    }
	
$packageArgs = @{
  packageName    = $packageName
  fileType       = $installerType
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  url64bit       = $url64  
  checksum64     = $checksum64
  checksumType64 = 'sha256'    
  FileFullPath   = $FileFullpath
}

Get-ChocolateyWebFile @packageArgs

Rename-Item $FileFullpath "VNC-Viewer.exe"
$FileFullPath = "$ToolsDir\VNC-Viewer.exe"
  
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -TargetPath $FileFullpath -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -TargetPath $FileFullpath
