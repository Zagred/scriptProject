#
# WindowsService.ps1
$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$rootPath  = (Get-Item $PSScriptRoot).Parent.Parent.FullName
. "$rootPath\Common\CommonFunctions.ps1"
. "$rootPath\Common\RemoteOperations.ps1"

$Global:localFilesPath = "C:\Published\BackgroundTasksService\USD.Test" 

$Global:remoteFilesPath = "C:\projects\WindowsServices\Usdirectory\BackgoundTasksService"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = "BackgoundTasksService.7z"

PublishWindowsService 
