$packageName      = 'hdhomerunviewer-plex' 
$BundleName       = 'HDHRViewerV2.bundle'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath

if ($LocalAppDataPath -eq $null) {
   Write-Host "Plex Media Server is not installed or has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
  
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Host "Removing .old version (2 versions old)." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
}Else{
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Host "Removing $packageName" -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName" -recurse | out-null
}Else{
  Write-Host "ERROR: No previous version exists. Nothing done." -ForegroundColor green -BackgroundColor blue
}


