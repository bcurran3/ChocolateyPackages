$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.0.2-Windows-32bit.exe'
$checksum       = 'B9F53F05F29E64F63244F560DCDC46E5EE07B3C531DA4D0F5C4DD3A237659024'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.0.2-Windows-64bit.exe'
$checksum64     = '8195890C66CCF93DFC00DC465C4EF10200B0305D2A5BDBBBBEDBAA9702444BFB'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.0.2-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.0.2-Windows-64bit.exe'

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