$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:remoteFilesPath = "C:\projects\Sites\test-cadcloud.uncut.cloud\" 

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "cadcloud.test"
$Global:AngularAppPublishPath = "C:\Published\Apps\Cadcloud.Test"


PublishApps 


