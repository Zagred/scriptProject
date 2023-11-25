#
# ScheduledTasks.ps1
# Publich "Trunk" svn branch to test.shoogerservices.com
#
$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$rootPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:localFilesPath = "C:\published\Processors\USD.Test\" 
$Global:remoteFilesPath = "C:\projects\Processors\Usdirectory\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = "UsdProcessors.7Z"

PublishProcessors
