$ErrorActionPreference = 'Stop'
$packageName     = 'snappy-driver-installer' 
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url             = 'http://www.sdi-tool.org/releases/SDI_R535.zip' 
$checksum        = '08D439A3A94095BF78C27F461D1DA00E71892AC94E51667A597699A3534C4A39'
$fileName32      = 'SDI_R535.exe'
$fileName64      = 'SDI_x64_R535.exe'
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

if (Get-OSArchitectureWidth -eq 64)
    {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath $FileFullpath64 -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath $FileFullpath64
    } else {
   Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName.lnk" -targetPath $FileFullpath32 -WorkingDirectory "$toolsDir"
   Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName.lnk" -targetPath $FileFullpath32
    }