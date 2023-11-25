# 20200401 Miro : Publich "Prelife" svn branch to test.shooger.com
#
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Uncut.Prelife"
$Global:remoteFilesPath = "C:\projects\Sites\prelife.uncut.cloud\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = "Uncut.7z"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "prelife.uncut.cloud";

$Global:AngularProjectPath = "c:\Projects\AssetManager\Prelife\app\"
$Global:AngularConfiguration = "uncut.prelife"
$Global:AngularPublishPath = "C:\Published\Site\Uncut.PreLife\app"

PublishSite


