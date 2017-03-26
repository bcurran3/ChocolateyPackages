$packageName    = 'dokany-redistributable'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dokan-dev/dokany/releases/download/v1.0.3/DokanSetup_redist.exe'
$checksum       = '38710F89F716326AB0A83DE17270B70F4D96452DC0B34B654EA1B29B5B17BAB7'
$silentArgs     = '/install /passive /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Dokan Library*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
