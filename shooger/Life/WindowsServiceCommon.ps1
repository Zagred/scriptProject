# 20181030 Miro : Common variables for media.shooger.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "C:\Published\BackgroundTasksService\Shooger.Release"
$Global:remoteFilesPath ="C:\projects\WindowsServices\Shooger\BackgoundTasksService\" 

$Global:BackupFolder = "C:\projects\Backup\BackgroundTasksService\"
$Global:BackupFile =  $BackupFolder + "" + $mydate + "_ShoogerBackgroundTasksService.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = $Global:mydate + "-ShoogerBackgroundTasksService.7z"

#services are transfered on usdn1
$Global:Server = "usdn1.corp.shooger.com"


