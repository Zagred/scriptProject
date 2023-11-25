#
# 20201015 Miro : Initial version
# 20201023 to .net core

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\GearSix.Test"
$Global:remoteFilesPath = "C:\projects\Sites\test.gearsix.io\" 
$Global:projectBuildFile = $branchFolder[0] + "\Web\Web.csproj"
$Global:transferZipFileName = $Global:mydate + "-gearsix.7z"

$Global:msbuild = $Global:msbuildCore6
$Global:DotnetCoreProject = $true
$Global:RestartSiteOnTransfer = $true

$Global:CopyToServers = @("BGWEBUNCUTEST01.uncut.local")
$Global:CopyInRamFolder = "RAMProjects$\Sites\test.gearsix.io\"

PublishSite

