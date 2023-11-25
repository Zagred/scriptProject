#
# Publich "branches/prelife" svn branch to https://prelife-media.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Media\Shooger.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife-media.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerMediaAPI\ShoogerMediaAPI.csproj"
$Global:transferZipFileName = "PreLifeShoogerMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\ShoogerMediaAPI\"
$toPictures =  "\\$Server\c$\projects\Sites\prelife-media.shooger.com\" 

$Global:SiteName = "prelife-media.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite 
