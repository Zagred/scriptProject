# Publish "branches/prelife" svn branch to https://prelife.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\USD.PreLife"
$Global:remoteFilesPath = "C:\projects\sites\prelife.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "PreLifeUSDNet.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "prelife.usdirectory.com";
$Global:RestartSiteOnTransfer = $true

PublishSite
