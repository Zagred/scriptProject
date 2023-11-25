# 20181031 Miro : Publish life service
# 20200330 Miro : Adjust script to transfer in usd server usdn1 
# 20200730 Miro : Restructure/simplify variables and includes
#
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life windows service
$Global:localFilesPath = "C:\Published\BackgroundTasksService\Uncut.Stage"
$Global:remoteFilesPath ="C:\Projects\WindowsServices\Uncut\BackgroundTasksService\"

$Global:BackupFolder = "C:\projects\Backup\BackgroundTasksService\"
$Global:BackupFile =  $BackupFolder + "" + $mydate + "_UncutBackgroundTasksService.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = $Global:mydate + "BackgroundTasksService.7z"

PublishWindowsService 

