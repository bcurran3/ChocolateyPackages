$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.18.625-Windows-32bit.exe'
$checksum       = '1193008CC8F2EA13435D911E23640877A44CCCD09BA27C301C7B9D3C594EE5D2'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.18.625-Windows-64bit.exe'
$checksum64     = '11FDD8C46595704F61CC690439D26D8EB89406C056159E18B07BEBB35DB7AC06'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.18.625-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.18.625-Windows-64bit.exe'

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
