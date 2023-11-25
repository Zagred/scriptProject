#
# 20230428 Miro : Initial version
# 

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\GearSix.Release"
$Global:remoteFilesPath = "C:\projects\Sites\gearsix.io\" 
$Global:projectBuildFile = $branchFolder[0] + "\Web\Web.csproj"
$Global:transferZipFileName = $Global:mydate + "-gearsix.7z"

$Global:msbuild = $Global:msbuildCore6
$Global:DotnetCoreProject = $true
$Global:RestartSiteOnTransfer = $true

$Global:CopyToServers = @("USWEBUNCUTPRD01.uncut.local")
$Global:CopyInRamFolder = "RAMProjects$\Sites\gearsix.io\"

PublishSite

