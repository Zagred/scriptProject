# 20181030 Miro : Common variables for services.usdirectory.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:localFilesPath = "c:\Published\Services\USD.Release"
$Global:remoteFilesPath ="C:\projects\Sites\services.usdirectory.com\" 

$Global:BackupFolder = "C:\projects\Backup\Services\"
$Global:BackupFile =  $BackupFolder + $mydate + "_UsdServices.7z"
$Global:BackupPath = $remoteFilesPath + "*.*"

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = $Global:mydate + "-UsdServices.7z"

$Global:CopyInRamFolder = "RAMProjects$\Sites\services.usdirectory.com\"
$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","usdn1.corp.shooger.com","Webserver02.corp.shooger.com")

$Global:RemoveGlimpse = $true

