$packageName = 'betterhash' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.betterhash.net/download/BetterHash_Setup.exe'
$checksum    = '2007E7B9AA715E8D92F91C8B697261028245AC58DEDB5D0A0FC60594E745A89B'
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



