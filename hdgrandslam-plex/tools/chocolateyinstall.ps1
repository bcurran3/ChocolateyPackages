$packageName      = 'hdgrandslam-plex' 
$BundleName       = 'HDGrandSlam.bundle'
$BundleVer        = '1.6.2'
$url              = 'https://github.com/jumpmanjay/HDGrandSlam.bundle/archive/v1.6.2.zip'
$checksum         = 'D79FD30991832022DBEBE1FCD4EAA0FB210D92A5038623F6381B70C7CC8B31B6'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath | out-null

if ($LocalAppDataPath -eq $null) {
   Write-Host "Plex Media Server is not installed or has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   Write-Host "Creating default directories..." -ForegroundColor green -BackgroundColor blue
   New-Item "$env:LOCALAPPDATA\Plex" -Type Directory -force | out-null
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server" -Type Directory -force | out-null
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server\Plug-ins" -Type Directory -force | out-null
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
  
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Host "Removing .old version (2 versions old)." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName.old" -recurse | out-null
}Else{
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Host "Renaming previously installed version .old." -ForegroundColor green -BackgroundColor blue
  Rename-Item "$UnZipDir\$BundleName" "$BundleName.old" | out-null
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

Rename-Item "$UnZipDir\$BundleName-$Bundlever" $BundleName | out-null
