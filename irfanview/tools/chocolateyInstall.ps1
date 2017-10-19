$packageName    = 'irfanview'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\iview450_setup.exe"
$checksum       = '1568576EDCDFD95382154538299E01F58AE9D0B863E24F176BF8D97B8D2D4E33'
$checksumType   = 'sha256'
$url64          = "$toolsDir\iview450_x64_setup.exe"
$checksum64     = 'AA0BDF15331CABAF02C96B1027525EF42D5068C1C999DC3B6BBD1903B24977B3'
$checksumType64 = 'sha256'
$validExitCodes = @(0)
$arguments      = @{}
$packageParameters = $env:chocolateyPackageParameters

Write-Debug "Default values for package parameters: 0=off, 1=on"
$desktop = 0
$thumbs = 0
$group = 0
$allusers = 1
$assoc = 0
$ini = "%APPDATA%\IrfanView"
$folder = $null

if ($packageParameters) {
    $match_pattern = "\/(?<option>([a-zA-Z]+))=(?<value>([`"'])?([a-zA-Z0-9- _\\:%\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
    $option_name = 'option'
    $value_name = 'value'

    if ($packageParameters -match $match_pattern ){
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | ForEach-Object {
          $arguments.Add(
              $_.Groups[$option_name].Value.Trim(),
              $_.Groups[$value_name].Value.Trim())
      }
    } else {
        Throw "Package Parameters were found but were invalid (REGEX failure)"
    }

    if ($arguments.ContainsKey("desktop")) {
        Write-Verbose "Adding desktop shortcut to IrfanView"
        $desktop = 1
    }

    if ($arguments.ContainsKey("thumbs")) {
        Write-Verbose "Adding desktop shortcut to IrfanView Thumbnails"
        $thumbs = 1
    }

    if ($arguments.ContainsKey("group")) {
        Write-Verbose "Adding IrfanView group to start menu"
        $group = 1
    }
    
    if ($arguments.ContainsKey("allusers")) {
        Write-Verbose "Installing IrfanView for only current user"
        $allusers = 0
    }
    
    if ($arguments.ContainsKey("assoc")) {
        Write-Verbose "Associating IrfanView to file types"
        $assoc = $arguments["assoc"]
    }

    if ($arguments.ContainsKey("ini")) {
        Write-Verbose "You want to use a custom configuration Path"
        $ini = $arguments["ini"]
    }
    
    if ($arguments.ContainsKey("folder")) {
        Write-Verbose "You want to use a custom configuration Path"
        $folder = $arguments["folder"]
    }

} else {
    Write-Debug "No package parameters passed in"
}

$silentArgs = "/silent" + 
              " /desktop=" + $desktop + 
              " /thumbs=" + $thumbs + 
              " /group=" + $group + 
              " /allusers=" + $allusers +
              " /assoc=" + $assoc
if ($ini) { $silentArgs += " /ini=" + $ini }
if ($folder) { $silentArgs += " /folder=" + $folder }
Write-Debug "Silent arguments Chocolatey will use are: $silentArgs"

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'IrfanView*'
  checksum      = $checksum
  checksumType  = $checksumType
  Checksum64    = $checksum64
  ChecksumType64= $checksumType64
}

Install-ChocolateyPackage @packageArgs 	

Remove-Item $url | out-null
Remove-Item $url64 | out-null