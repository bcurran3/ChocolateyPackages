$packageName    = 'chromiumbsu'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/chromium-bsu/Chromium%20B.S.U.%20Win32%20binary/chromium-0.9.13.2.exe' 
$checksum       = '61C8F51FDE637AA4158A9347EFEE30B2300A8A0406A950D977A5C398BFFED4C5'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Chromium B.S.U.*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
