$packageName   = 'expandrive' 
$url           = 'https://downloads.expandrive.com/expandrive_win/v6-4-3_published_2019-01-24_at_20_18_35/ExpanDrive_Setup_6.4.3.exe' 
$checksum      = 'CB49D851011B5E92892CF834EC3DB0CE024B66E38A52EE1C32F039CA46CC5115'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = ''
  softwareName  = 'Expandrive*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Start-CheckandStop "ExpanDrive"
Install-ChocolateyPackage @packageArgs
Sleep 5
if ($GLOBAL:ProcessWasRunning -eq $False) {Start-CheckandStop "ExpanDrive*"}
# ^ doesn't necessary work in this case - try loop in the future while ExpanDrive_Setup_x.x.x.ex runs