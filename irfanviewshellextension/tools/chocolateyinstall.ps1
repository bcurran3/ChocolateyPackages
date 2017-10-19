#http://www.irfanview.net/plugins/irfanview_shell_extension.zip
$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'irfanviewshellextension-codecs' 
$url            = "$toolsDir\irfanview_shell_extension.zip"
$checksum       = '8ADA7D71BCD073F5024C80848EC778EFEB8F3691A382F05D52A5362518F50F29'
$bits           = Get-ProcessorBits
$32bitDLL       = 'IrfanViewShellExt.dll'
$64bitDLL       = 'IrfanViewShellExt64.dll'
$Found          = "False"

if (Test-Path $Env:ProgramFiles\IrfanView){
    $Found = "True"
    $ShellDir = "$Env:ProgramFiles\IrfanView\Shell Extension"
	if ($bits -eq 64){
	   $UseDLL = $64bitDLL
	   $DLLDir = '64 bit'
	   } else {
	   $UseDLL = $32bitDLL
	   $DLLDir = '32 bit'
	   }
   } else {
     if (Test-Path "{$Env:ProgramFiles(x86)}\IrfanView"){
	     $Found = "True"
         $ShellDir = "{$Env:ProgramFiles(x86)}\IrfanView\Shell Extension"
		 $UseDLL = $32bitDLL
		 $DLLDir = '32 bit'
        }
}
		  
if ($Found -eq "True"){
    New-Item $ShellDir -type directory -force | out-null
    Write-Host "Irfanview default install path found!" -foreground green -backgroundcolor blue
	} else{
	 Write-Host "Cannot find IrfanView install location. Aborting." -foreground red -backgroundcolor blue
	 throw
	}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  }

Install-ChocolateyZipPackage @packageArgs

Copy-Item "$toolsDir\$DLLDir\$UseDLL" -Destination $ShellDir
& regsvr32.exe /s $ShellDir\$UseDLL
Remove-Item $url | out-null
Remove-Item "$toolsDir\32 bit" -recurse | out-null
Remove-Item "$toolsDir\64 bit" -recurse | out-null
Remove-Item "$toolsDir\Readme_first.txt" | out-null
