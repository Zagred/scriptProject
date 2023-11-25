# 20181022 Miro : Publich "Trunk" svn branch to test.uncut.cloud
# 20200330 :  transfer on new environment
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\Office.USD.Release"
$Global:remoteFilesPath = "C:\projects\Sites\office.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = $Global:mydate + "-office.shooger.com.7z"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "office.shooger.com";

$Global:AngularProjectPath = "c:\Projects\AssetManager-Office\app\"
$Global:AngularConfiguration = "office.usd.prod"
$Global:AngularPublishPath = $Global:localFilesPath + "\app"

$Global:CopyInRamFolder = "RAMProjects$\sites\office.shooger.com\"
$Global:CopyFolder = "projects$\sites\office.shooger.com\"
$Global:CopyToServers = @("webserver01.corp.shooger.com")

PublishSite



