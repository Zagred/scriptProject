# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:BackupFolder = "C:\projects\Backup\Media\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Shooger.7z"
$Global:BackupPath = "C:\projects\Sites\media.shooger.com\*.*"

$Global:localFilesPath = "c:\Published\Media\Shooger.Release"
$Global:remoteFilesPath ="C:\projects\Sites\media.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerMediaAPI\ShoogerMediaAPI.csproj"
$Global:transferZipFileName = $Global:mydate + "-ShoogerMedia.7z"

#copy to all servers
$Global:CopyInRamFolder = "RAMProjects$\Sites\media.shooger.com\"
$Global:CopyFolder = "projects$\sites\media.shooger.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","usdn1.corp.shooger.com","Webserver02.corp.shooger.com")

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
$toPictures =  "\\$Server\c$\projects\Sites\media.shooger.com\" 

$Global:RemoveGlimpse = $true

