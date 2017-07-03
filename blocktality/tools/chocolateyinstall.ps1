$packageName    = 'blocktality'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/blocktality/blocktality/1.0.1/blocktality-1.0.1.exe' 
$checksum       = 'BE6E670BE26F867ADAE8CBA5BE5DE0343E030357287302B0523659AD1690A317'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Blocktality'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
