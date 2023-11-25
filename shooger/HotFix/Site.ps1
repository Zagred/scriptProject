# Publish "branches/hotfixshooger" svn branch to hotfix.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Shooger.HotFix"
$Global:remoteFilesPath = "D:\Projects\Shooger\hotfix.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "ShoogerNet.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "hotfix.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite

