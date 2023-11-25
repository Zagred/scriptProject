#
# 20181023 Miro 
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\published\Processors\Shooger.Test\" 
$Global:remoteFilesPath = "C:\projects\Processors\Shooger\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerProcessors\ShoogerProcessors.csproj"
$Global:transferZipFileName = "ShoogerProcessors.7z"

PublishProcessors