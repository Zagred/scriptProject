#
# 20181214 Diyan 
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\published\Processors\Office.USD.Test\" 
$Global:remoteFilesPath = "C:\projects\Processors\Uncut"
$Global:projectBuildFile = $branchFolder[0] + "\Uncut\Processors\Processors.csproj"
$Global:transferZipFileName = "Processors.7z"

PublishProcessors