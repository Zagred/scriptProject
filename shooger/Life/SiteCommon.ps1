# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Shooger.7z"
$Global:BackupPath = "C:\projects\Sites\shooger.com\*.*"

$Global:localFilesPath = "c:\Published\Site\Shooger.Release"
$Global:remoteFilesPath ="C:\projects\Sites\shooger.com\" 

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = $Global:mydate + "-ShoogerWeb.7z"

$Global:CopyInRamFolder = "RAMProjects$\Sites\shooger.com\"
$Global:CopyFolder = "projects$\sites\shooger.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","Webserver02.corp.shooger.com","usdn1.corp.shooger.com","usdn2.corp.shooger.com")

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:RemoveGlimpse = $true
