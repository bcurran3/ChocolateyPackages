#$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'password-checkup-chrome'
$extensionID = 'pncabnpcffmalkkjpajodfhijclecjno'
if ($bits -eq 64)
   {
    if (Test-Path -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID")
       {
       Write-Host "Extension already installed." -Foreground Magenta
       } else {
         New-Item -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" | Out-Null
         New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx" | Out-Null
         New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID\" -Name "ChocolateyPackageName" -Value "$packageName"	| Out-Null
         }
    } else {
      New-Item -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" | Out-Null
      New-ItemProperty -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx" | Out-Null
    }
