
# 20220227 Miro : Initial

$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\published\Processors\Uncut.Stage\" 
$Global:remoteFilesPath = "C:\projects\Processors\Uncut\"

$Global:BackupFolder = "C:\projects\Backup\Processors\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Uncut.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Uncut\Processors\Processors.csproj"
$Global:transferZipFileName = $mydate + "-Uncut.7z"

$Global:Server = "USWEBUNCUTSTG01.uncut.local"

PublishProcessors


