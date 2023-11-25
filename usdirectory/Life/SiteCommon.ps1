# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#

$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Usdirectory.7z"
$Global:BackupPath = "C:\projects\Sites\usdirectory.com\*.*"

$Global:localFilesPath = "c:\Published\Site\USD.Release"
$Global:remoteFilesPath ="C:\projects\Sites\usdirectory.com\" 

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = $Global:mydate + "-usdirectory.7z"

$Global:CopyInRamFolder = "RAMProjects$\sites\usdirectory.com\"
$Global:CopyFolder = "projects$\sites\usdirectory.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","Webserver02.corp.shooger.com","usdn1.corp.shooger.com","usdn2.corp.shooger.com")

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:RemoveGlimpse = $true

# pictures copy variables
#$fromPictures = $null # $branchFolder[0]+"\Shooger\UsdMediaSite\"
#$toPictures =   $null # "\\$Server\c$\projects\Sites\media.usdirectory.com\"


