$ErrorActionPreference = 'Stop'
$packageName= 'amazondrive'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://d29x207vrinatv.cloudfront.net/win/AmazonDriveSetup.exe' 
$silentArgs = "-q"
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Amazon Drive*'
  checksum      = 'A49DA4EFE299FF78C1359341AE6A1F512C118B09CA8F3E4D20615714D998DE13'
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