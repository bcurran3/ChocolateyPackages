$ErrorActionPreference = 'Stop'
$packageName      = 'stinger' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe'
$checksum         = 'B7C2ABC9DD81F5328CA0ED32F2E7AE472C897948768997F532D011F85F54E8C3'
$url64            = 'http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger64.exe'
$checksum64       = 'FEA599F638391C4F910D2C72132C591348FE67809CB4EC3334F268477F27F914'
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

Show-Patreon "https://www.patreon.com/bcurran3"
Get-ChocolateyWebFile @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Install-BinFile -Name stinger -Path $toolsDir\$ExeFile
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
 Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\McAfee Stinger.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
