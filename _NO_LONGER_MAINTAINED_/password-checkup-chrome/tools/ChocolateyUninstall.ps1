#$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'password-checkup-chrome'
$extensionID = 'pncabnpcffmalkkjpajodfhijclecjno'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | Out-Null
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | Out-Null
}
