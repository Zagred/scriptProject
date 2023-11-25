# 20181022 Miro : Publich "Trunk" svn branch to test.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Shooger.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "ShoogerNet.7z"

$Global:UpdateCss = $Global:localFilesPath + "\Web.config"

$Global:SiteName = "test.shooger.com";
$Global:RestartSiteOnTransfer = $true

$Global:CopyInRamFolder = "RAMProjects\Sites\test.shooger.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")

PublishSite
