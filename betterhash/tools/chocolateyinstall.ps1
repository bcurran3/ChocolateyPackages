$packageName = 'betterhash' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.betterhash.net/download/BetterHash_Setup.exe'
$checksum    = '6C4A3C22E7CC41A864538F86F1CCFB94B924A2E9D0509EA9E1399DC2FE63DB6A'
$bits        = Get-ProcessorBits

if ($bits -eq 32)
   {
	Write-Host "BetterHash is 64 bit only. Aborting." -foreground red -backgroundcolor blue
	throw
   } else {
     $packageArgs = @{
      packageName   = $packageName
      unzipLocation = $toolsDir
      fileType      = 'exe' 
      url           = $url
      silentArgs    = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
      softwareName  = 'BetterHash' 
      checksum      = $checksum
      checksumType  = 'sha256'
    }
   Install-ChocolateyPackage @packageArgs   
  }



