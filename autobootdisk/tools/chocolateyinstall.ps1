$packageName    = 'autobootdisk'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://raw.githubusercontent.com/EvilSourcerer/AutoBootDisk/master/AutoBootDisk5.5.msi' 
$checksum       = '62353BB964561F35D9973F060CCE46D280AE28EF31E97A76B3BC43D683468045'
$silentArgs     = '/quiet /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'AutoBootDisk'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
