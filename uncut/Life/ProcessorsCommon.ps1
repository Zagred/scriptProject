# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "C:\published\Processors\Uncut.Release\" 
$Global:remoteFilesPath = "C:\projects\Processors\Uncut\"

$Global:BackupFolder = "C:\projects\Backup\Processors\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Uncut.7z"
$Global:BackupPath = "$remoteFilesPath\*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Uncut\Processors\Processors.csproj"
$Global:transferZipFileName =  $mydate + "_UncutProcessors.7z"

#$Global:Server = "WORKGROUP\uncut01"
#$Global:Server = "usdn2.corp.shooger.com"




