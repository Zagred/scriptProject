#
#
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\BackgroundTasksService\Shooger.Prelife" 
$Global:remoteFilesPath = "C:\projects\WindowsServices\ShoogerPreLife\BackgroundTasksService\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = "ShoogerPreLifeBackgoundTasksService.7z"

PublishWindowsService 
