$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

# Everything for life site
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SiteCommon.ps1"

$Global:AngularProjectPath = "D:\Projects\AssetManager\Prelife\app\"
$Global:AngularAppPublishPath = "C:\Published\Apps\Uncut.Release\"


PublishApps 


