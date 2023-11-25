# 20181022 Miro : Publich "Trunk" svn branch to test.shoogerservices.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Services\Shooger.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.shoogerservices.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\www.shoogerservices.com\www.shoogerservices.com.csproj"
$Global:transferZipFileName = "ShoogerServices.7z"

$Global:SiteName = "test.shoogerservices.com";
$Global:RestartSiteOnTransfer = $true

$Global:CopyInRamFolder = "RAMProjects\Sites\test.shoogerservices.com\"
#$Global:CopyFolder = "projects$\sites\services.usdirectory.com\"
$Global:CopyToServers = @("BGWEBTEST01")

PublishSite