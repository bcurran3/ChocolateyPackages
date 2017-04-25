$ErrorActionPreference = 'Stop'
$packageName     = 'snappy-driver-installer' 
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url             = 'https://svwh.dl.sourceforge.net/project/snappy-driver-installer/SDI_R539.zip' 
$checksum        = '2B430EFE794ABDAB7DB446EF3DA9BFA5979DAE15280B1E8C8BF50EC77400F4CE'
$fileName32      = 'SDI_RR539.exe'
$fileName64      = 'SDI_x64_R539.exe'
$FileFullpath32  = Join-Path $ToolsDir\SDI_R539 $fileName32
$FileFullpath64  = Join-Path $ToolsDir\SDI_R539 $fileName64
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