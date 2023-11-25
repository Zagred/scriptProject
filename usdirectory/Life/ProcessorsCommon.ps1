# 20181030 Miro : Common variables for media.shooger.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "C:\Published\Processors\USD.Release"
$Global:remoteFilesPath = "C:\projects\Processors\Usdirectory\" 

$Global:BackupFolder = "C:\projects\Backup\Processors\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Usdirectory.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = $Global:mydate + "-UsdProcessors.7z"

$Global:Server = "usdn2.corp.shooger.com"

$Global:DeleteTransferredArchive = $false
