$bits = Get-ProcessorBits
$packageName = 'slickrss-chrome'
$extensionID = 'ealjoljnibpdkocmldliaoojpgdkcdob'

if ($bits -eq 64){
     Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
   } else {
     Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
}
