#
# 20181023 Miro 
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\BackgroundTasksService\Shooger.Test" 
$Global:remoteFilesPath = "C:\projects\WindowsServices\Shooger\BackgroundTasksService\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = "BackgoundTasksService.7z"

PublishWindowsService 