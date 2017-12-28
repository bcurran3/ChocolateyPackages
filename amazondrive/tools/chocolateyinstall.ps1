$ErrorActionPreference = 'Stop'
$packageName   = 'amazondrive'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://d29x207vrinatv.cloudfront.net/win/AmazonDriveSetup.exe' 
$checksum      = '6C1CC3CCC91459371FB01788A9CF4ED5BFB3BEAFFC854637ECBC58A325AA9644'
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