# 20181030 Miro : Common variables for services.shooger.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "c:\Published\Services\Shooger.Release"
$Global:remoteFilesPath ="C:\projects\Sites\services.shooger.com\" 

$Global:BackupFolder = "C:\projects\Backup\Services\"
$Global:BackupFile =  $BackupFolder + $mydate + "_ShoogerServices.7z"
$Global:BackupPath = $remoteFilesPath + "*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = $Global:mydate + "-ShoogerServices.7z"

$Global:CopyInRamFolder = "RAMProjects$\Sites\services.shooger.com\"
$Global:CopyFolder = "projects$\sites\services.shooger.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","usdn1.corp.shooger.com","Webserver02.corp.shooger.com")

$Global:RemoveGlimpse = $true