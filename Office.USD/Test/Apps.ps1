# 20220509 Volen : Publish Uncut Apps

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:remoteFilesPath = "C:\projects\Sites\test-office.shooger.com\" 

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "office.usd.test"
$Global:AngularAppPublishPath = "c:\Published\Apps\Office.USD.Test\"

$Global:CopyInRamFolder = "RAMProjects\sites\test-office.shooger.com\Downloads\"
$Global:CopyToServers = @("bgwebtest01.corp.shooger.com")

PublishApps 


