function Get-IsAMDVideo{
$VideoCard=(Get-WmiObject win32_VideoController).description
if ($VideoCard -match "AMD") {return $true} else {return $false}
}  