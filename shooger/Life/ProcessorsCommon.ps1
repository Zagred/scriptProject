# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "C:\published\Processors\Shooger.Release\" 
$Global:remoteFilesPath = "C:\projects\Processors\Shooger\"

$Global:BackupFolder = "C:\projects\Backup\Processors\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Shooger.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = $Global:mydate + "-ShoogerProcessors.7z"

$Global:Server = "usdn2.corp.shooger.com"


$Global:DeleteTransferredArchive = $false

