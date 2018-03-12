$packageName    = 'irfanview'

if (Test-Path -Path $ENV:ProgramFiles\IrfanView\iv_uninstall.exe)
   {
    &$ENV:ProgramFiles\IrfanView\iv_uninstall.exe /silent
   } else {
    &${ENV:ProgramFiles(x86)}\IrfanView\iv_uninstall.exe /silent
   }

