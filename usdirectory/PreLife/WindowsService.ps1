#
#
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\BackgroundTasksService\USD.Prelife" 
$Global:remoteFilesPath = "C:\projects\WindowsServices\UsdirectoryPreLife\BackgroundTasksService\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = "USDPreLifeBackgoundTasksService.7z"

PublishWindowsService 
