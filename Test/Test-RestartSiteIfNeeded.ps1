$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$rootPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"


$Global:RestartSiteOnTransfer = $true
$Global:SiteName = "test.uncut.cloud"

 RestartSiteIfNeeded