# 20181022 Miro : Publich "Trunk" svn branch to test.uncut.cloud
# 20200330 :  transfer on new environment
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Uncut.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.uncut.cloud\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = "Uncut.7z"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "testuncut.cloud";

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "uncut.test"
$Global:AngularPublishPath = "C:\Published\Site\Uncut.Test\app"

# test purposes, transfer to new bgwebtest02. Remove after it is tested
$Global:CopyFolder = "RAMProjects$\Sites\test.uncut.cloud\"
$Global:CopyToServers = @("BGWEBUNCUTEST01.uncut.local")

PublishSite



