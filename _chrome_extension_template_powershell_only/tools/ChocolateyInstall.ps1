$bits = Get-ProcessorBits
$extensionID = ''
if ($bits -eq 64)
{
New-Item -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Value “default value”
New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx"
}
else
{
New-Item -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Value “default value”
New-ItemProperty -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx"
}
