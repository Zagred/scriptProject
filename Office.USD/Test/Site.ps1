# 20181022 Miro : Publich "Trunk" svn branch to test.uncut.cloud
# 20200330 :  transfer on new environment
# 20200512 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Office.USD.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test-office.shooger.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = $Global:mydate + "test-office.shooger.com.7z"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "test-office.shooger.com";

$Global:AngularProjectPath = "c:\Projects\AssetManager-Office\app\"
$Global:AngularConfiguration = "office.usd.test"
$Global:AngularPublishPath = $Global:localFilesPath + "\app"

$Global:CopyInRamFolder = "RAMProjects\sites\test-office.shooger.com\"
$Global:CopyToServers = @("bgwebtest01.corp.shooger.com")


PublishSite



