$ErrorActionPreference = 'Stop'
$packageName  = 'office2019-homeandbusiness' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/HomeBusiness2019Retail.img'
$checksum     = ''
$FileFullpath = "$ToolsDir\HomeBusiness2019Retail.img"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'ISO'
  url           = $url
  FileFullPath  = $FileFullpath
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
