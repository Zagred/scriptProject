## 20200402 Miro : Publich to test.sugarshackanimation.com
# 20200512 Miro : Restructure/simplify variables and includes
#

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\HandsdownStudios.Test"
$Global:remoteFilesPath = "C:\Projects\Sites\test.handsdownstudios.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Web\Web.csproj"
$Global:transferZipFileName = $Global:mydate + "-handsdownstudios.7z"

$Global:msbuild = $Global:msbuildCore6
$Global:DotnetCoreProject = $true
$Global:RestartSiteOnTransfer = $true

$Global:CopyToServers = @("BGWEBUNCUTEST01.uncut.local")
$Global:CopyInRamFolder = "RAMProjects$\Sites\test.handsdownstudios.com\"

PublishSite
