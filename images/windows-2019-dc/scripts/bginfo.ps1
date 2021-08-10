$ErrorActionPreference = "Stop"

# Variables
$uri = "https://download.sysinternals.com/files/BGInfo.zip"

# Create folder
$targetFolder = "C:\Program Files\Bginfo"
New-Item $targetFolder -Itemtype Directory

# Get BGInfo
Invoke-WebRequest -Uri $uri -OutFile $targetFolder\bginfo.zip
Expand-Archive -Path $targetFolder\bginfo.zip -DestinationPath $targetFolder

# Create shortcut
$targetFile          = "$targetFolder\BGinfo.exe"
$shortcutFile        = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Bginfo.lnk"
$scriptShell         = New-Object -ComObject WScript.Shell -Verbose
$shortcut            = $scriptShell.CreateShortcut($shortcutFile)
$shortcut.TargetPath = $targetFile
$arg1                = """$targetFolder\mdb.bgi"""
$arg2                = "/timer:0 /accepteula"
$shortcut.Arguments  = $arg1 + " " + $arg2
$shortcut.Save()