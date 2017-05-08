$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.1.0-Windows-32bit.exe'
$checksum       = '73EA87CC8D706A00AD6095F32F0DF32103BB10B1B49DDC2A001788A4B95E7FB4'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.1.0-Windows-64bit.exe'
$checksum64     = 'CFADBB7A4E89D66A1D55DC4DF672D339C39BA4BCF190527BD5EDBB5BEDC2349B'
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