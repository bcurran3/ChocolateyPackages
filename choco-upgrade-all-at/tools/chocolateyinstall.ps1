$packageName = 'choco-upgrade-all-at'
$ErrorActionPreference = 'Stop'
$pp = Get-PackageParameters
$RunTime = ''

if ($pp["Time"] -eq $null -or $pp["Time"] -eq '')
    { 
     $RunTime = '00:00' 
     Write-Host "No time specified, defaulting to midnight."
    }
if ($pp["Time"] -eq '30')        { $RunTime = '12:30' }
if ($pp["Time"] -eq '030')       { $RunTime = '12:30' }
if ($pp["Time"] -eq '1')         { $RunTime = '01:00' }
if ($pp["Time"] -eq '130')       { $RunTime = '01:30' }
if ($pp["Time"] -eq '2')         { $RunTime = '02:00' }
if ($pp["Time"] -eq '230')       { $RunTime = '02:30' }
if ($pp["Time"] -eq '3')         { $RunTime = '03:00' }
if ($pp["Time"] -eq '330')       { $RunTime = '03:30' }
if ($pp["Time"] -eq '4')         { $RunTime = '04:00' }
if ($pp["Time"] -eq '430')       { $RunTime = '04:30' }
if ($pp["Time"] -eq '5')         { $RunTime = '05:00' }
if ($pp["Time"] -eq '530')       { $RunTime = '05:30' }
if ($pp["Time"] -eq '6')         { $RunTime = '06:00' }
if ($pp["Time"] -eq '630')       { $RunTime = '06:30' }
if ($pp["Time"] -eq '7')         { $RunTime = '07:00' }
if ($pp["Time"] -eq '730')       { $RunTime = '07:30' }
if ($pp["Time"] -eq '8')         { $RunTime = '08:00' }
if ($pp["Time"] -eq '830')       { $RunTime = '08:30' }
if ($pp["Time"] -eq '9')         { $RunTime = '09:00' }
if ($pp["Time"] -eq '930')       { $RunTime = '09:30' }
if ($pp["Time"] -eq '10')        { $RunTime = '10:00' }
if ($pp["Time"] -eq '1030')      { $RunTime = '10:30' }
if ($pp["Time"] -eq '11')        { $RunTime = '11:00' }
if ($pp["Time"] -eq '1130')      { $RunTime = '11:30' }
if ($pp["Time"] -eq '12')        { $RunTime = '12:00' }
if ($pp["Time"] -eq '1230')      { $RunTime = '12:30' }
if ($pp["Time"] -eq '13')        { $RunTime = '13:00' }
if ($pp["Time"] -eq '1330')      { $RunTime = '13:30' }
if ($pp["Time"] -eq '14')        { $RunTime = '14:00' }
if ($pp["Time"] -eq '1430')      { $RunTime = '14:30' }
if ($pp["Time"] -eq '15')        { $RunTime = '15:00' }
if ($pp["Time"] -eq '1530')      { $RunTime = '15:30' }
if ($pp["Time"] -eq '16')        { $RunTime = '16:00' }
if ($pp["Time"] -eq '1630')      { $RunTime = '16:30' }
if ($pp["Time"] -eq '17')        { $RunTime = '17:00' }
if ($pp["Time"] -eq '1730')      { $RunTime = '17:30' }
if ($pp["Time"] -eq '18')        { $RunTime = '18:00' }
if ($pp["Time"] -eq '1830')      { $RunTime = '18:30' }
if ($pp["Time"] -eq '19')        { $RunTime = '19:00' }
if ($pp["Time"] -eq '1930')      { $RunTime = '19:30' }
if ($pp["Time"] -eq '20')        { $RunTime = '20:00' }
if ($pp["Time"] -eq '2030')      { $RunTime = '20:30' }
if ($pp["Time"] -eq '21')        { $RunTime = '21:00' }
if ($pp["Time"] -eq '2130')      { $RunTime = '21:30' }
if ($pp["Time"] -eq '22')        { $RunTime = '22:00' }
if ($pp["Time"] -eq '2230')      { $RunTime = '22:30' }
if ($pp["Time"] -eq '23')        { $RunTime = '23:00' }
if ($pp["Time"] -eq '2330')      { $RunTime = '23:30' }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco upgrade all at" /TR "choco upgrade all --confirm" /ST $RunTime /F
Write-Host "Now configured to run choco upgrade all at '$RunTime' every day."

