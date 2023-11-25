#
# 20181030 Miro : Publish test service
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"


$Global:ServiceName = "Background Tasks service (UsdOffice)"
$Global:localFilesPath = "C:\Published\BackgroundTasksService\Office.USD.Test" 
$Global:remoteFilesPath = "C:\Projects\WindowsServices\OfficeShooger\BackgroundTasksService\"
$Global:projectBuildFile = $branchFolder + "\BackgroundTasksService\BackgroundTasksService.csproj"
$Global:transferZipFileName = "UsdOfficeBackgoundTasksService.7z"

PublishWindowsService 
