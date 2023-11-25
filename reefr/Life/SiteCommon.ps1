# 20181030 Miro 
# 20200513 Miro : Restructure/simplify variables and includes
#
$Global:makeBackup = $true
$Global:BackupFolder = "C:\projects\Backup\Site\"
$Global:BackupFile =  $BackupFolder + $mydate + "_Reefr.7z"
$Global:BackupPath = "C:\projects\Sites\Reefr.shop\*.*"

$Global:localFilesPath = "c:\Published\Site\Reefr.Release"
$Global:remoteFilesPath ="C:\projects\Sites\Reefr.shop\" 

$Global:transferZipFileName = "Reefr.7z"

$Global:CopyFolder = "projects$\sites\reefr.shop\"
$Global:CopyToServers = @("Webserver01.corp.shooger.com","Webserver02.corp.shooger.com","usdn1.corp.shooger.com")

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"
$Global:RemoveGlimpse = $true

#$toPictures =   $null # "\\$Server\c$\projects\Sites\media.usdirectory.com\"$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
#$toPictures =   $null # "\\$Server\c$\projects\Sites\media.usdirectory.com\"$toPictures =  "\\$Server\c$\projects\Sites\media.shooger.com\" 
