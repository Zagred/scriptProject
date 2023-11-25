# 20181022 Miro : Publich "Trunk" svn branch to test.uncut.cloud
# 20200330 :  transfer on new environment
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Cadcloud.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test-cadcloud.uncut.cloud\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = "Cadcloud.7z"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "test-cadcloud.uncut.cloud";

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "cadcloud.test"
$Global:AngularPublishPath = "C:\Published\Site\Cadcloud.Test\app"

# test purposes, transfer to new bgwebtest02. Remove after it is tested
#$Global:CopyFolder = "projects\sites\test.uncut.cloud\"
#$Global:CopyToServers = @("bgwebtest02.corp.shooger.com")



PublishSite



