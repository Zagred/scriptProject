# Publich "Trunk" svn branch to test.usdirectory.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\USD.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.usdirectory.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "UsdWebSite.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "test.usdirectory.com";
$Global:RestartSiteOnTransfer = $true
$Global:CopyInRamFolder = "RAMProjects\Sites\test.usdirectory.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")
PublishSite

