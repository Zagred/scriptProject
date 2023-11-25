#
# MediaSite.ps1 : Publich "Trunk" svn branch to test-media.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Media\USD.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test-media.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\UsdMediaSite\UsdMediaSite.csproj"
$Global:transferZipFileName = "UsdMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\UsdMediaSite\"
$toPictures =  "\\$Server\c$\projects\Sites\test-media.usdirectory.com\" 

$Global:SiteName = "test-media.usdirectory.com";
$Global:RestartSiteOnTransfer = $true

$Global:CopyInRamFolder = "RAMProjects\Sites\test-media.usdirectory.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")

PublishSite 

