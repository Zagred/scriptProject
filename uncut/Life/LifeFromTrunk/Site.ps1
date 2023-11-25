## 20181022 Miro : Publich "Trunk" svn branch to uncut.cloud
# 20200330 Miro : Adjust script to transfer in usd servers usdn1 and usdn2
# 20200730 Miro : Restructure/simplify variables and includes
$AutomaticVariables = Get-Variable

$ourPath =  (Get-Item $PSScriptRoot).FullName
. "$ourPath\CommonVariables.ps1"

# Everything for life site
$parentPath  = (Get-Item $PSScriptRoot).Parent.FullName
. "$parentPath\SiteCommon.ps1"

$Global:AngularProjectPath = "c:\Projects\AssetManager\app\"
$Global:AngularPublishPath = "C:\Published\Site\Uncut.Release\app"

$Global:CopyInRamFolder = "RAMProjects$\sites\uncut.cloud\"
$Global:CopyFolder = "projects$\sites\uncut.cloud\"
$Global:CopyToServers = @("uncut02")

$Global:UseSession = $false

PublishSite
