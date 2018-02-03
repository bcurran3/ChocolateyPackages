function Get-IsNvidiaVideo{
$VideoCard=(Get-WmiObject win32_VideoController).description
if ($VideoCard -match "Nvidia") {return $true} else {return $false}
}  
