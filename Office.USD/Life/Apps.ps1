# 20220509 Volen : Publish Uncut Apps

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:remoteFilesPath = "C:\projects\Sites\office.shooger.com\" 

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "office.usd.prod"
$Global:AngularAppPublishPath = "c:\Published\Apps\Office.USD.Release\"

$Global:CopyInRamFolder = "RAMProjects$\sites\office.shooger.com\Downloads\"
$Global:CopyFolder = "projects$\sites\office.shooger.com\Downloads\"
$Global:CopyToServers = @("webserver01.corp.shooger.com")

PublishApps 


