#
# WebService.ps1
# Publich "Trunk" svn branch to test-services.usdirectory.com
#

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$rootPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:localFilesPath = "C:\Published\Services\USD.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test-services.usdirectory.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = "UsdServices.7z"

$Global:SiteName = "test-services.usdirectory.com";
$Global:RestartSiteOnTransfer = $true
$Global:CopyInRamFolder = "RAMProjects\Sites\test-services.usdirectory.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")
PublishSite
