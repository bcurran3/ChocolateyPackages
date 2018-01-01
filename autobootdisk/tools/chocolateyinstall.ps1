$packageName    = 'autobootdisk'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/EvilSourcerer/AutoBootDisk/blob/master/AutoBootDisk5.5.msi' 
$checksum       = '029C34B9FF18691B36195B1BCEA3194A810C705F8AC05C6B6DE985F502F8C592'
$silentArgs     = '/s /v"/qn"'
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
  
