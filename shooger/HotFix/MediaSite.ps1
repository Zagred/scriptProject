#
# Publich "branches/hotfixshooge" svn branch to hotfix-media.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"
 
$Global:localFilesPath = "C:\Published\Media\Shooger.HotFix"
$Global:remoteFilesPath = "D:\Projects\Shooger\hotfix.media.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerMediaAPI\ShoogerMediaAPI.csproj"
$Global:transferZipFileName = "ShoogerMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
$toPictures =  "\\$Server\c$\projects\Sites\hotfix-media.shooger.com\" 

$Global:SiteName = "hotfix-media.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite 
