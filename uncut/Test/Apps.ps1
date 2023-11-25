# 20220509 Volen : Publish Uncut Apps

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:remoteFilesPath = "C:\projects\Sites\test.uncut.cloud\" 

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularConfiguration = "uncut.test"
$Global:AngularAppPublishPath = "C:\Published\Apps\Uncut.Test\"


PublishApps 


