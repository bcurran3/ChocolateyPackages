$ErrorActionPreference = 'Stop'
$packageName     = 'snappy-driver-installer' 
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url             = 'http://www.sdi-tool.org/releases/SDI_R1742.zip' 
$checksum        = '6A072DB13655236F25F884532BC7FD896EBEB238DC31379CB6941CB675A1AE89'
$fileName32      = 'SDI_R1742.exe'
$fileName64      = 'SDI_x64_R1742.exe'
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