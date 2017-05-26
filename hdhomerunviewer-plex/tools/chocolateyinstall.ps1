$packageName      = 'hdhomerunviewer-plex' 
$BundleName       = 'HDHRViewerV2.bundle'
$BundleVer        = ''
$url              = 'https://github.com/zynine-/HDHRViewerV2.bundle/releases/download/1.0.2/HDHRViewerV2.bundle.zip'
$checksum         = 'D26B13642FDFD38FF9F6368C6B9FB225A6D6E70254450305D070E7A0BDDE8E21'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath

if ($LocalAppDataPath -eq $null) {
   Write-Host "Plex Media Server is not installed or has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   Write-Host "Creating default directories..." -ForegroundColor green -BackgroundColor blue
   New-Item "$env:LOCALAPPDATA\Plex" -Type Directory -force | out-null
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server" -Type Directory -force | out-null
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server\Plug-ins" -Type Directory -force | out-null
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
  
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins\$BundleName"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Host "Removing .old version (2 versions old)." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir.old" -recurse | out-null
}Else{
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Host "Renaming previously installed version .old." -ForegroundColor green -BackgroundColor blue
  Rename-Item "$UnZipDir" "$BundleName.old" | out-null
}Else{
  Write-Host "No previous version exists." -ForegroundColor green -BackgroundColor blue
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $UnZipDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

#Rename-Item "$UnZipDir\$BundleName-$Bundlever" $BundleName | out-null