function Get-IsInDomain{
if ($env:LOGONSERVER) {return $true} else {return $false}
}