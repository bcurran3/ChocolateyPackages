#$ErrorActionPreference = 'Stop'
$packageName  = 'homeassistant'
$shortcutName = 'Home Assitant.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Home Assistant normal install
pip3 install homeassistant

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath 'py' -Arguments '-m homeassistant --open-ui' -IconLocation "$toolsDir\homeassistant.ico" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath 'py' -Arguments '-m homeassistant --open-ui' -IconLocation "$toolsDir\homeassistant.ico" -RunAsAdmin

# REFERENCE
# Home Assistant run command
# py -m homeassistant --open-ui

# Home Assistant upgrade command (must shutdown first)
# pip3 install --upgrade homeassistant

# Home Assistant Python virtual environment install
#py -m venv homeassistant
#cd homeassistant
#Scripts\activate.bat
#py -m pip install wheel setuptools pip
#py -m pip install homeassistant

# Home Assistant Python virtual environment run command
#hass

# Home Assistant Python virtual environment upgrade command  (must shutdown first)
#cd homeassistant
#Scripts\activate.bat
#py -m pip install --upgrade homeassistant
