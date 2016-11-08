$packageName= 'dns-benchmark' 
$url        = 'https://www.grc.com/files/DNSBench.exe' 
$ToolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$installerPackage = Join-Path $ToolsDir "DNSBench.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = '0BAF546D6AC9FD853B11CBA89D3F314CA3FF0CA791224AA0753F0441A396DBE7'
  checksumType  = 'sha256'
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\DNS Benchmark.lnk" -targetPath "$ToolsDir\DNSBench.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark.lnk" -targetPath "$ToolsDir\DNSBench.exe"
