# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\USD.Design"
$Global:remoteFilesPath = "C:\projects\Sites\design-test.usdirectory.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "DesignUsdirectory.7z"

$Global:RestartSiteOnTransfer = $true

PublishSite