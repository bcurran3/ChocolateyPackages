$bits = Get-ProcessorBits
$packageName = 'google-cast-chrome'
$extensionID = 'boadgeojelhgndaghljhdicfkmllpafd'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
}
