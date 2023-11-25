# 20181030 Miro : Common variables for media.shooger.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "C:\Published\BackgroundTasksService\Uncut.Release"
$Global:remoteFilesPath ="C:\Projects\WindowsServices\Uncut\BackgroundTasksService\"

$Global:BackupFolder = "C:\projects\Backup\BackgroundTasksService\"
$Global:BackupFile =  $BackupFolder + "" + $mydate + "_UncutBackgroundTasksService.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = $mydate + "_BackgroundTasksService.7z"

$Global:Server = "uncut01.uncut.local"

