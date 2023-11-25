#
# Publich "branches/prelife" svn branch to https://prelife-media.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Media\USD.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife-media.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\UsdMediaSite\UsdMediaSite.csproj"
$Global:transferZipFileName = "PreLifeUSDMedia.7z"

# pictures copy variables
$fromPictures = $branchFolder[0]+"\Shooger\UsdMediaSite\"
$toPictures =  "\\$Server\c$\projects\Sites\prelife-media.usdirectory.com\" 

$Global:SiteName = "prelife-media.usdirectory.com";
$Global:RestartSiteOnTransfer = $true

PublishSite 
