#
# Publich "branches/hotfixshooger" svn branch to hotfix-media.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"
 
$Global:localFilesPath = "C:\Published\Media\USD.HotFix"
$Global:remoteFilesPath = "C:\projects\Sites\hotfix-media.usdirectory.com" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\UsdMediaSite\UsdMediaSite.csproj"
$Global:transferZipFileName = "HotfixUsdComMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\UsdMediaSite\"
$toPictures =  "\\$Server\c$\projects\Sites\hotfix-media.usdirectory.com\" 

$Global:SiteName = "hotfix-media.usdirectory.com";
$Global:RestartSiteOnTransfer = $true

PublishSite 


