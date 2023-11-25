#
# 
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\published\Processors\Shooger.PreLife\" 
$Global:remoteFilesPath = "c:\projects\Processors\ShoogerPreLife\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = "PreLifeShoogerProcessors.7z"

PublishProcessors