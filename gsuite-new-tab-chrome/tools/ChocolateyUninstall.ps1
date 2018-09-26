$bits = Get-ProcessorBits
$packageName = 'gsuite-new-tab-chrome'
$extensionID = 'ehpgcagmhpndkmglombjndkdmggkgnge'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
}
