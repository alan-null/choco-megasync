$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$toolsPath\${packageName}.zip"
$url = 'https://mega.nz/MEGAsyncSetup.exe'
Get-ChocolateyWebFile $packageName $fileFullPath $url

$packageArgs = @{
    PackageName = "megasync"
    File        = $fileFullPath
    File64      = $fileFullPath
    Destination = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

Remove-Item -force "$toolsPath\*.zip" -ea 0
Install-ChocolateyShortcut -ShortcutFilePath "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\MEGAsync.lnk" -TargetPath "$toolsPath\MEGAsync.exe"
