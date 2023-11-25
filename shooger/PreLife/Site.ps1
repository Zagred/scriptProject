# Publish "branches/prelife" svn branch to https://prelife.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Shooger.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "PreLifeShoogerNet.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "prelife.shooger.com";
$Global:RestartSiteOnTransfer = $true

PublishSite
