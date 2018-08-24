# https://sourceforge.net/projects/filebot/files/filebot/FileBot_4.7.9/
$packageName    = 'filebot-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$url32          = "$toolsDir\FileBot_4.7.9_x86.msi"
$checksum32     = '5D827EED2D0DE7F43B8190782DEBD903B9AFFA47E8B4469E037416EBC869E15F'
$url64          = "$toolsDir\FileBot_4.7.9_x64.msi" 
$checksum64     = '93B80A068F8A6226259E8165E743754B81C668F6D7FCB59E8A17839DEA771790'

if ($bits -eq 64)
   {
    $url=$url64
	$checksum=$checksum64
   } else {
     $url=$url32
	 $checksum=$checksum32
   }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'FileBot'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
Remove-Item $url32
Remove-Item $url64
