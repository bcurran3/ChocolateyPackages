$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.0.3-Windows-32bit.exe'
$checksum       = 'A643B6AA14FD3D09E346E5B6CFD2A9E193C6702DEC4233D14B45FF535BEBA58A'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.0.3-Windows-64bit.exe'
$checksum64     = '8BBCDDC0D0E08A958AA9B5C3C18C1AE1DA5858BF5750C377A017D7FAD266794F'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.0.3-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.0.3-Windows-64bit.exe'

if (Get-OSArchitectureWidth -eq 64)
    {
     $FileFullpath = Join-Path $ToolsDir $fileName64
    } else {
     $FileFullpath = Join-Path $ToolsDir $fileName32
    }
	
$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64  
  checksum64    = $checksum64
  checksumType64= 'sha256'    
  FileFullPath  = $FileFullpath
}

Get-ChocolateyWebFile @packageArgs
  
if (Get-OSArchitectureWidth -eq 64)
    {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -TargetPath $FileFullpath -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -TargetPath $FileFullpath
    } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -TargetPath $FileFullpath -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -TargetPath $FileFullpath
    }