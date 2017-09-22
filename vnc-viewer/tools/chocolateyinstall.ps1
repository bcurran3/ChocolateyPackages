$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.731-Windows-32bit.exe'
$checksum       = '4937E3CF1586E0973A1224111422A13577F51454683D55F97E1108794379C009'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.731-Windows-64bit.exe'
$checksum64     = 'B2216EB26678851CA9862F936B4057516933CFECB343B4FCA54B5170339D2063'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.17.731-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.17.731-Windows-64bit.exe'

if ((Get-OSArchitectureWidth -eq 64) -and ($env:chocolateyForceX86 -ne $true))
    {
     $FileFullpath = Join-Path $ToolsDir $fileName64
    } else {
     $FileFullpath = Join-Path $ToolsDir $fileName32
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
  
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -TargetPath $FileFullpath -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -TargetPath $FileFullpath
