#Creates Intune Folder if it does not exist
$intunefolder = "C:\Windows\Intune Resources"
if (!(Test-Path -path $intunefolder)) {New-Item $intunefolder -Type Directory}

#Copies DesktopInfo Files to Intune Resources\DesktopInfo
New-Item "C:\Windows\Intune Resources\DesktopInfo" -Type Directory
Copy-Item "DesktopInfo64.exe" -Destination "C:\Windows\Intune Resources\DesktopInfo"
Copy-Item "desktopinfo.ini" -Destination "C:\Windows\Intune Resources\DesktopInfo"

#Creates shortcut
$TargetFile = "C:\Windows\Intune Resources\DesktopInfo\DesktopInfo64.exe"
$ShortcutFile = "C:\Windows\Intune Resources\DesktopInfo\DesktopInfo64.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

#Copies shortcut into each users startup folder
$startup = 'C:\Users\*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup'
Get-ChildItem $startup | ForEach-Object {Copy-Item "C:\Windows\Intune Resources\DesktopInfo\DesktopInfo64.lnk" -Destination $_ -Force}