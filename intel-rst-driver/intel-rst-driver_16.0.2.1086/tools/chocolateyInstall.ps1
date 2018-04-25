$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/27681/eng/SetupRST.exe'
$checksum    = '213F5DEC27628CB81D2396F2DF67F1E054F4CA9FAF008BEDD2A06D83D8BF6214'
$silentArgs  = '-s' 

if ((Get-IsWin10 -eq $false) -and (Get-IsWinServer2016 -eq $false)){
   Write-Host "This version is Windows 10 and Windows Server 2016 only." -foreground "red" –backgroundcolor "blue"
   throw
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'Intel(R) Rapid Storage Technology' 
  }

Install-ChocolateyPackage @packageArgs

