# 20200402 Miro :  Publich to sugarshackanimation.com
# 20200512 Miro : Restructure/simplify variables and includes
# 20230428 Miro : Adjust variables for the new server USWEBUNCUTPRD01

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\HandsdownStudios.Release"
$Global:remoteFilesPath = "C:\Projects\Sites\handsdownstudios.com\" 
$Global:projectBuildFile = $branchFolder[0] + "\Web\Web.csproj"
$Global:transferZipFileName = $Global:mydate + "-HandsdownStudios.7z"

$Global:msbuild = $Global:msbuildCore6
$Global:DotnetCoreProject = $true
$Global:RestartSiteOnTransfer = $true

$Global:CopyToServers = @("USWEBUNCUTPRD01.uncut.local")
$Global:CopyInRamFolder = "RAMProjects$\Sites\handsdownstudios.com\"

PublishSite
