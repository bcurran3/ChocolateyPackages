REF: https://stackoverflow.com/questions/41602754/get-website-metadata-such-as-title-description-from-given-url-using-powershell


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
    $result = Invoke-WebRequest -Uri 'https://downloadcenter.intel.com/download/28425' -Method Get
	$resultTable = @{}
	$resultTable.title = $result.ParsedHtml.title
	$HtmlTag = $result.ParsedHtml.ch#ildNodes | Where-Object {$_.nodename -eq 'HTML'} 
	$HeadTag = $HtmlTag.childNodes | Where-Object {$_.nodename -eq 'HEAD'}
	$MetaTags = $HeadTag.childNodes| Where-Object {$_.nodename -eq 'META'}
	$resultTable.keywords = $metaTags  | Where-Object {$_.name -eq 'keywords'} | Select-Object -ExpandProperty content
	$resultTable.description = $metaTags  | Where-Object {$_.name -eq 'description'} | Select-Object -ExpandProperty content
	Write-Output New-Object -TypeName PSCustomObject -Property $resultTable
	
 #   $regex      = 'ipscan-\d\.\d[\d\.]*-setup.exe$'
 #   $url        = 'https://downloadmirror.intel.com/28425/a08/Intel-Driver-and-Support-Assistant-Installer.exe'
    
  #  $version    = ($url -split '[/]' | select -Last 1 -Skip 1)

    return @{ Version = $version; URL32 = $url}
}

Update-Package -ChecksumFor none -NoReadme
