# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:makeBackup = $true
$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_safeco.7z"
$Global:BackupPath = "C:\projects\Sites\safeco.shooger.com\*.*"

$Global:localFilesPath = "c:\Published\Site\safeco.shooger.com"
$Global:remoteFilesPath ="C:\projects\Sites\safeco.shooger.com\" 

$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "safeco.7z"

$Global:CopyFolder = "projects$\sites\safeco.shooger.com\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","Webserver02.corp.shooger.com","usdn1.corp.shooger.com")

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:RemoveGlimpse = $true

# pictures copy variables
#$toPictures =   $null # "\\$Server\c$\projects\Sites\media.usdirectory.com\"$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
#$toPictures =   $null # "\\$Server\c$\projects\Sites\media.usdirectory.com\"$toPictures =  "\\$Server\c$\projects\Sites\media.shooger.com\" 

