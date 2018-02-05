function Get-IsIntelVideo{
$VideoCard=(Get-WmiObject win32_VideoController).description
if ($VideoCard -match "Intel") {return $true} else {return $false}
}  