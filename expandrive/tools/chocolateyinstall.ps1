$packageName   = 'expandrive' 
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v6-3-0_published_2018-11-02_at_17_00_12/ExpanDrive_Setup_6.3.0.exe' 
$checksum      = '3799BEA249E9AC91263AF5AA3F469FD0A8D6BC038E62A3B5AA1C4D1FF34A7432'

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

#Start-CheckandStop "ExpanDrive"
Install-ChocolateyPackage @packageArgs
#Start-Sleep -s 10
#if (!($ProcessWasRunning -eq "True")) {Start-CheckandStop "ExpanDrive"}
