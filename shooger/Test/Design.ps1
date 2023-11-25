# 20181024 Miro : Publich "Trunk" svn branch to design-test.shooger.com
# 20200512 Miro : Restructure/simplify variables and includes

$AutomaticVariables = Get-Variable

$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\CommonVariables.ps1"

$Global:localFilesPath = "C:\Published\Site\Shooger.Design"
$Global:remoteFilesPath = "C:\projects\Sites\design-test.shooger.com\"
$Global:projectBuildFile = $branchFolder[0] + "\Shooger\ShoogerNet\ShoogerNet.csproj"
$Global:transferZipFileName = "DesignShoogerNet.zip"

$Global:configuration = "Shooger.Design"
$Global:projectPublishProfile = "Shooger.Design.pubxml"

$Global:RestartSiteOnTransfer = $true

PublishSite
