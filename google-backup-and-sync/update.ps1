#needs AU module installed
#needs MSI module installed
Import-Module AU
Import-Module MSI
Import-Module "$env:ChocolateyInstall/helpers/chocolateyInstaller.psm1"
. ".\scripts\Update-OnETagChanged.ps1"

#declare the URLs globally, because they do not change between versions
$url32 = 'https://dl.google.com/drive/gsync_enterprise.msi'
$url64 = 'https://dl.google.com/drive/gsync_enterprise64.msi'

function global:au_SearchReplace {
    @{
        #Replace the checksums with the updated checksums
        "tools\chocolateyInstall.ps1" = @{    
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

#download the file at $url32 and checks it's version
function GetResultInformation([string]$url32) {

  #Download file to temp, and get the version via the MSI module
  $fileName = Split-path -Leaf $url32
  $dest = "$($env:temp)\$((new-guid).guid)\$fileName"
  Get-WebFile $url32 $dest
  $version = (Get-MSIProperty -Path $dest -Property ProductVersion).value.tostring()

  return @{
    URL64          = $url64
    URL32          = $url32
    Version        = $version
    RemoteVersion  = $version
  }
}

function global:au_GetLatest {
  #Download and check the version only if the file at $url32 has been changed. 
  $result = Update-OnETagChanged -execUrl $url32 -OnEtagChanged {
    GetResultInformation $url32
  } -OnUpdated { @{ URL32 = $url32 } }

  return $result
}

Update-Package