$ErrorActionPreference = 'Stop'
$packageName  = 'office2019-pro' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/Professional2019Retail.img'
$checksum     = ''
$FileFullpath = "$ToolsDir\Professional2019Retail.img"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'ISO'
  url           = $url
  FileFullPath  = $FileFullpath
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
