$packageName    = 'google-web-designer' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B811767F4-C586-4673-A41F-E9D767497222%7D%26iid%3D%7B9574833B-1F2E-A48D-D001-02A2109E3493%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Web%2520Designer%26needsadmin%3DTrue/webdesigner/win/shell/googlewebdesigner_win.exe'
$checksum       = '39F80D038CC69FD3C236E3E5EECC8129075106EB037672CBD0E9B1738EEA46CC'
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


