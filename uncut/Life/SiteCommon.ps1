#
# 20200730 Miro : Restructure/simplify variables and includes
#
$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_UncutWebSite.7z"
$Global:BackupPath = "C:\Projects\Sites\uncut.cloud\*.*"

$Global:localFilesPath = "c:\Published\Site\Uncut.Release"
$Global:remoteFilesPath = "C:\Projects\Sites\uncut.cloud\"

$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = $Global:mydate + "-Uncut.Cloud.7z"

$Global:CopyFolder = "projects$\sites\uncut.cloud\"

$Global:RemoveGlimpse = $true
$Global:RestartSiteOnTransfer = $true
$Global:AngularConfiguration = "uncut.prod"
