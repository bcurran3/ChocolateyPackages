Import-Module AU

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
        }
    }
}

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -NoSuffix
}


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri https://github.com/angryip/ipscan/releases -UseBasicParsing
	
    $regex      = 'ipscan-\d\.\d[\d\.]*-setup.exe$'
    $url        = $download_page.links | ? href -match $regex | % href | select -First 1
    $modurl     = 'https://github.com' + $url 
    
    $version    = ($url -split '[/]' | select -Last 1 -Skip 1)

    return @{ Version = $version; URL32 = $modurl}
}

Update-Package -ChecksumFor none -NoReadme
