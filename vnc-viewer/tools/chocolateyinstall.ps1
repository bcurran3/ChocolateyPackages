# https://www.realvnc.com/en/connect/download/viewer/
$ErrorActionPreference = 'Stop'
$packageName    = 'vnc-viewer'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-$ENV:ChocolateyPackageVersion-Windows-32bit.exe"
$checksum       = 'A8FB44F338D744D3E85745CD17FAAEB7686E1F434361EFB33E6C26897B6A2A79'
$url64          = "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-$ENV:ChocolateyPackageVersion-Windows-64bit.exe"
$checksum64     = 'C23C58236CA2D7EC2F5923B41A9064D08471C57627908E64639C4418AC6E2AA9'
$shortcutName   = 'VNC Viewer' 
$fileName32     = "VNC-Viewer-$ENV:ChocolateyPackageVersion-Windows-32bit.exe"
$fileName64     = "VNC-Viewer-$ENV:ChocolateyPackageVersion-Windows-64bit.exe"

#Start-CheckandThrow("VNC-Viewer")

if ((Get-OSArchitectureWidth -eq 64) -and ($ENV:chocolateyForceX86 -ne $True))
    {
     $FileFullpath = "$ToolsDir\$fileName64"
    } else {
     $FileFullpath = "$ToolsDir\$fileName32"
    }
	
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
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
  
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName.lnk" -TargetPath $FileFullpath -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -TargetPath $FileFullpath
