﻿$ErrorActionPreference = 'Stop'
$bits = Get-ProcessorBits
$packageName = 'chrono-chrome'
$extensionID = 'mciiogijehkdemklbdcbfkefimifhecn'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
