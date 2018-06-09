$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = '03E4FFB340829746E38D5EB908FD20FA8C593C254347D3D3C396F5AC72833A5F'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = '0EB5F20C45C7E6785302083B0C598AC2A90518FF78DF9CFA04D25E5F7AFC8490'
$ExeFile32        = 'stinger32.exe'
$ExeFile64        = 'stinger64.exe'
$ShortcutName     = 'McAfee Stinger'
$bits             = Get-ProcessorBits

if ($bits -eq 64)
   {
    $installerPackage = Join-Path $toolsDir $ExeFile64
	$ExeFile = $ExeFile64
   } else {
    $installerPackage = Join-Path $toolsDir $ExeFile32
	$ExeFile = $ExeFile32
 }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'  
  FileFullPath  = $installerPackage
  softwareName  = ''
  }

Get-ChocolateyWebFile @packageArgs

Install-BinFile -Name stinger -Path $toolsDir\$ExeFile
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
 Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
