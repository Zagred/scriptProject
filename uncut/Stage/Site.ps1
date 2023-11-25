# 20220226 Miro : Initial
$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "c:\Published\Site\Uncut.Stage"
$Global:remoteFilesPath = "C:\projects\Sites\stage.uncut.cloud\" 
$Global:projectBuildFile = $branchFolder[0] + "\Site\Site.csproj"
$Global:transferZipFileName = $Global:mydate + "Uncut.7z"

$Global:CopyToServers = @("USWEBUNCUTSTG01.uncut.local")
$Global:CopyInRamFolder = "RAMProjects$\Sites\stage.uncut.cloud\"

$Global:RestartSiteOnTransfer = $true

$Global:SiteName = "stage.uncut.cloud";

$Global:AngularProjectPath = "c:\Projects\AssetManager-Stage\app\"
$Global:AngularConfiguration = "uncut.stage"
$Global:AngularPublishPath = "C:\Published\Site\Uncut.Stage\app"

PublishSite


