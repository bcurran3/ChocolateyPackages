$ErrorActionPreference = 'Stop'
$packageName     = 'snappy-driver-installer' 
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url             = 'https://sdi-tool.org/releases/SDI_R2201.zip' 
$checksum        = '44BFE7243DD089F4886545E05EBE7AEBC9ED2BA492E648FD73C53945B0703FCA'
$fileName32      = 'SDI_R2201.exe'
$fileName64      = 'SDI_x64_R2201.exe'
$FileFullpath32  = Join-Path $ToolsDir $fileName32
$FileFullpath64  = Join-Path $ToolsDir $fileName64
$shortcutName    = 'Snappy Driver Installer' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

if (Get-OSArchitectureWidth -Compare 64)
    {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath $FileFullpath64 -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath $FileFullpath64
    } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath $FileFullpath32 -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath $FileFullpath32
    }