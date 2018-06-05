$packageName      = '-plex' 
$BundleName       = '.bundle'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath

if ($LocalAppDataPath -eq $null) {
   Write-Host "Plex Media Server has not been configured yet!" -ForegroundColor red
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
  
$UnZipDir = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Host "Removing previous .old version." -ForegroundColor magenta
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
}Else{
  Write-Host ".old version does not exist." -ForegroundColor magenta
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Host "Removing $packageName" -ForegroundColor magenta
  Remove-Item "$UnZipDir\$BundleName" -recurse
}Else{
  Write-Host "ERROR: No previous version exists." -ForegroundColor red
}
  Write-Host "You can ignore Only an exit code of non-zero will fail... messages." -ForegroundColor magenta

