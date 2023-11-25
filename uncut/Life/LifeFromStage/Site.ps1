# 20220308 Miro : Copied from trunk script

$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life site
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SiteCommon.ps1"

$Global:AngularProjectPath = "c:\Projects\AssetManager-Stage\app\"
$Global:AngularPublishPath = "C:\Published\Site\Uncut.Release\app"

$Global:CopyInRamFolder = "RAMProjects$\sites\uncut.cloud\"
$Global:CopyFolder = "projects$\sites\uncut.cloud\"
$Global:CopyToServers = @("USWEBUNCUTPRD01.uncut.local")

#$Global:UseSession = $false

PublishSite
