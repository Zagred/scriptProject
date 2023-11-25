# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:makeBackup = $true
$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Shooger.7z"
$Global:BackupPath = "C:\projects\Sites\loggedin.io\*.*"

$Global:localFilesPath = "c:\Published\Site\Loggedin.Release"
$Global:remoteFilesPath ="C:\projects\Sites\loggedin.io\" 

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "loggedin.7z"

$Global:CopyFolder = "projects$\sites\loggedin.io\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","Webserver02.corp.shooger.com","usdn1.corp.shooger.com")

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:RemoveGlimpse = $true

