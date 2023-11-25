#
# 20181022 Miro : Publich "Trunk" svn branch to test-media.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"
 
$Global:localFilesPath = "C:\Published\Media\Shooger.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test-media.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerMediaAPI\ShoogerMediaAPI.csproj"
$Global:transferZipFileName = "ShoogerMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
$toPictures =  "\\$Server\c$\projects\Sites\test-media.shooger.com\" 

$Global:SiteName = "test-media.shooger.com";
$Global:RestartSiteOnTransfer = $true

$Global:CopyInRamFolder = "RAMProjects\Sites\test-media.shooger.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")


PublishSite 
