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
  checksum      = 'C03D23B734567A3DEBA88FC58CF721F5233E9C958F03268D72984A2BF9AC48A5'
  checksumType  = 'sha256'
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\DNS Benchmark.lnk" -targetPath "$ToolsDir\DNSBench.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DNS Benchmark.lnk" -targetPath "$ToolsDir\DNSBench.exe"
