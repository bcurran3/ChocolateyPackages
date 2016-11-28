$ErrorActionPreference = 'Stop'
$packageName   = 'amazondrive'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://d29x207vrinatv.cloudfront.net/win/AmazonDriveSetup.exe' 
$checksum      = '7BB4FEC8E861E74E01E4BE954F9033117926D6157D6E21D5F500AD61C3844F4F'
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