# Publish "branches/hotfixshooger" svn branch to hotfix.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\USD.HotFix"
$Global:remoteFilesPath = "C:\projects\Sites\hotfix.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "HotfixUsdCom.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "hotfix.usdirectory.com";
$Global:RestartSiteOnTransfer = $true

PublishSite
