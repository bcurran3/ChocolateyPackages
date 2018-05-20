$ErrorActionPreference = 'Stop'
$packageName   = 'amazondrive'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://d29x207vrinatv.cloudfront.net/win/AmazonDriveSetup.exe' 
$checksum      = '64759172FA0C81ACE739EF116172DD8A7C066B622139014DBE8E56DC034EC96C'
$silentArgs    = "-q"
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Amazon Drive*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
Start-Sleep -s 5
if((get-process "amazondrive" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "amazondrive currently NOT running." 
  }else{ 
    Write-Host "Stopping amazondrive process..."
    Stop-Process -processname "amazondrive"
  }
Start-Sleep -s 5