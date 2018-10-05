$ErrorActionPreference = 'Stop'
$packageName  = 'office2019-proplus' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/ProPlus2019Retail.img'
$checksum     = 'E9E53D5EABFF10717FAFD9B4A4D47DA0EF3B4AEA6F6A3F0399840114A299847F'
$FileFullpath = "$ToolsDir\ProPlus2019Retail.img"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'ISO'
  url           = $url
  FileFullPath  = $FileFullpath
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
