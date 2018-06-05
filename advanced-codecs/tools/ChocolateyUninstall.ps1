$packageName    = 'advanced-codecs'
$softwareName   = 'Shark007 ADVANCED Codecs*'

Start-Process -FilePath "msiexec.exe" -ArgumentList "/x {8C0CAA7A-3272-4991-A808-2C7559DE3409} /qn"
Start-Process -FilePath "$env:programfiles\Shark007\unins000.exe" -ArgumentList "/SILENT"