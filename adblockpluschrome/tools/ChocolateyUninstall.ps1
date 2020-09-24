﻿$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'adblockpluschrome'
$extensionID = 'cfhdojbkjhnklbpkdaibdccddilifddb'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue
}
