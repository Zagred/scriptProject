# 20181030 Miro : Common variables for media.shooger.com no matter of branch
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:BackupFolder = "C:\projects\Backup\Media\"
$Global:BackupFile =  $BackupFolder + $mydate + "_USD.7z"
$Global:BackupPath = "C:\projects\Sites\media.usdirectory.com\*.*"

$Global:localFilesPath = "c:\Published\Media\USD.Release"
$Global:remoteFilesPath ="C:\projects\Sites\media.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\UsdMediaSite\UsdMediaSite.csproj"
$Global:transferZipFileName = $Global:mydate + "-USDMedia.7z"

#copy to all servers
$Global:CopyInRamFolder = "RAMProjects$\sites\media.usdirectory.com\"
$Global:CopyFolder = "projects$\sites\media.usdirectory.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","usdn1.corp.shooger.com","Webserver02.corp.shooger.com")

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\UsdMediaSite\"
$toPictures =  "\\$Server\c$\projects\Sites\media.usdirectory.com\"

$Global:RemoveGlimpse = $true

$Global:Server = "usdn2.corp.shooger.com"