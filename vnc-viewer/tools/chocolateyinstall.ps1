$packageName    = 'vnc-viewer'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.1.1-Windows-32bit.exe'
$checksum       = '3786407669ce5b3b4f43da213e104321ce2491562be41396607d4506d874ca0b'
$url64          = 'https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.1.1-Windows-64bit.exe'
$checksum64     = 'e42481f62fbd0d63e506cb01e97cd4dea33bf005fffc890bf967b0e52b3282a9'
$shortcutName   = 'VNC Viewer' 
$fileName32     = 'VNC-Viewer-6.1.1-Windows-32bit.exe'
$fileName64     = 'VNC-Viewer-6.1.1-Windows-64bit.exe'

if (Get-OSArchitectureWidth -eq 64)
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
