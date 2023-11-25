#
# 
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\published\Processors\USD.PreLife\" 
$Global:remoteFilesPath = "c:\projects\Processors\UsdirectoryPreLife\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = "PreLifeUSDProcessors.7z"

PublishProcessors
