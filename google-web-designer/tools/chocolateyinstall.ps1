$packageName    = 'google-web-designer' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B811767F4-C586-4673-A41F-E9D767497222%7D%26iid%3D%7B14EEAC84-02FE-FACB-D056-1E2B65A25020%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Web%2520Designer%26needsadmin%3DTrue/webdesigner/win/shell/googlewebdesigner_win.exe'
$checksum       = '4C9B8CE5D4C38FD53EC0DB0A38F7C076FB53B9382C22624C8CD9180D489B985D'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '' 
  softwareName   = 'Google Web Designer*'
  checksum       = $checksum
  checksumType   = 'sha256'  
  validExitCodes = $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs

Start-Sleep -s 10

if((get-process "webdesigner" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "WebDesigner currently NOT running." 
  }else{ 
    Write-Host "Stopping WebDesigner process..."
    Stop-Process -processname "webdesigner"
  }


