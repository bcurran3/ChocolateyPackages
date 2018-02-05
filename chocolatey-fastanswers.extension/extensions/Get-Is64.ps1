function Get-Is64{
$Is64=(Get-WmiObject Win32_processor).addresswidth
 if ($Is64 -eq 64) {return $true} else {return $false}
}