$ErrorActionPreference = 'Stop'
$packageName    = 'readyshare-vault' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'ReadySHARE Vault'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  

NOTES:
ReadySHAREVault-install.exe /S works

need to task kill

svchost.exe                  19228 Services                   0      9,192 K
WmiPrvSE.exe                 18968 Services                   0     10,420 K
dllhost.exe                  19276 Console                    1     10,116 K
SearchProtocolHost.exe       16896 Services                   0     13,504 K
SearchFilterHost.exe         16996 Services                   0      8,084 K
explorer.exe                 18264 Console                    1     89,316 K
ShellExperienceHost.exe      17724 Console                    1     62,316 K
SearchUI.exe                 17296 Console                    1     92,048 K
backgroundTaskHost.exe       10624 Console                    1     30,368 K
GenieTimelineService.exe     16480 Services                   0     11,732 K
GenieTimeLineAgent.exe        6000 Console                    1     16,696 K
GenieTimeline.exe            17504 Console                    1     35,392 K
tasklist.exe