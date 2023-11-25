# 20200511 Miro: Restructure common files
# CommonVariables.ps1
#
$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\Logging.ps1"

$Global:platform = "Any CPU"
$Global:mydate = Get-Date -UFormat "%Y%m%d_%H%M"

if (![bool](gv username -s global -ea ig))
{
	$Global:username = "shooger\s_transfer_user"
}

$passwordText = Get-Content "c:\Projects\p"
$Global:password = convertto-securestring -AsPlainText -Force -String $passwordText    
Remove-Variable  -Name "passwordText"

$Global:RemoveGlimpse = $null

$Global:CopyFolder = $null
$Global:CopyToServers =$null

$Global:fromPictures = $null
$Global:toPictures = $null

$Global:MonitoringServiceName = "Zabbix Agent"

$Global:RestartSiteOnTransfer = $false

$Global:RestoreNugetPackages = $true

$Global:DotnetCoreProject = $false

# Backup related
$Global:makeBackup = $false
$Global:BackupFile = "empty"
$Global:BackupPath = "empty"
# Backup related

$Global:JobResultMarker = "Job Return Data = "

$Global:MediaFolders = $null

$Global:ServiceName = $null

$Global:UpdateCss = $null

$Global:svnPath = "C:\Program` Files\TortoiseSVN\bin\svn.exe"

$Global:svnUsername = "automaticbuild"
$Global:svnPassword = "`$RFVvgy7"

$Global:nugetPath = "C:\Program Files (x86)\Nuget\nuget.exe"
$Global:nugetConfig ="C:\Program` Files` (x86)\Nuget\nuget.config"

$Global:msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
$Global:msbuildCore = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
$Global:msbuildCore6 = "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
#$ngbuild = "C:\Users\miro\AppData\Roaming\npm\ng.cmd"
$Global:ngbuild = "ng"

$Global:updateCssVesion = "C:\Published\Tools\UpdateCssVersion\UpdateCssVesion.exe"

$Global:UseSession = $true

$Global:DeleteTransferredArchive = $true