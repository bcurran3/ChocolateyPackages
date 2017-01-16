$bits = Get-ProcessorBits
$packageName = 'quick-javascript-switcher-chrome'
$extensionID = 'geddoclleiomckbhadiaipdggiiccfje'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
