$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\Logging.ps1"

# 20160601 Author: Miroslav Braikov
# Create backup of a folder on remote machine using 7zip.
# If there is out of memory problem, run that on remote Set-Item WSMan:\localhost\Shell\MaxMemoryPerShellMB 4096
function CreateBackup
{
    param(
        $BackupFile = $(throw "Function param 'BackupFile' is required"),
        $RemoteFilesPath = $(throw "Function param 'RemoteFilesPath' is required"),
        $WithoutPictures = $true
    )
	Info "Creating zip from $RemoteFilesPath to $BackupFile" 
    
	if ($WithoutPictures)
    {
		$ArgumentsList = "a -y -m0=Copy -r -xr!*.7z -xr!*.zip -xr!*.gif -xr!*.jpg -xr!*.png  -xr!*.jpeg  -xr!*.jpe -xr!*.bmp -xr!*.tiff -xr!*.tif $BackupFile $RemoteFilesPath"
    }
    else
    {
        $ArgumentsList = "a -y -r -xr!*.7z -xr!*.zip -xr!Data\*.* $BackupFile $RemoteFilesPath"
    }

    $Job = Invoke-Command -Session $Session -Scriptblock { 
        param(
            $ArgumentsList = $(throw "Arguments is required")
        )
        
        $pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $pinfo.FileName = "c:\Program Files\7-Zip\7z.exe"
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        $pinfo.Arguments = $ArgumentsList
        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        echo $p.StandardOutput.ReadToEnd()
        echo $p.StandardError.ReadToEnd()

		Echo "Job Return Data = " $p.ExitCode


    } -ArgumentList $ArgumentsList -AsJob 
    Wait-Job $Job
    $JobResult = Receive-Job $Job
	CheckJobResult $Job $JobResult
	
	Warn "Backup completed" 
}

# 20160601 Author: Miroslav Braikov
# Start stop windows service
function ServiceJob
{
    param(
        $ServiceName = $(throw "Function param 'ServiceName' is required"),
        $Operation = $(throw "Function param 'Operation' is required")
    )
	Info "c:\windows\system32\net $Operation $ServiceName"
    $Job = Invoke-Command -Session $Session -Scriptblock { 
            param(
                $SServiceName = $(throw "Job param 'ServiceName' is required"),
                $SOperation = $(throw "Job param 'Operation' is required")
            )
    
            $pinfo = New-Object System.Diagnostics.ProcessStartInfo
            $pinfo.FileName = "c:\windows\system32\net"
            $pinfo.RedirectStandardError = $true
            $pinfo.RedirectStandardOutput = $true
            $pinfo.UseShellExecute = $false
            $pinfo.Arguments = "$SOperation `"$SServiceName`""
            $p = New-Object System.Diagnostics.Process
            $p.StartInfo = $pinfo
            $p.Start() | Out-Null
            #$p.WaitForExit()
            $p.StandardOutput.ReadToEnd()
            $p.StandardError.ReadToEnd()
		
			Echo "Job Return Data = " $p.ExitCode


        } -ArgumentList $ServiceName, $Operation -AsJob

    Wait-Job $Job
    $JobResult = Receive-Job $Job
	CheckJobResult $Job $JobResult
}
# 20170328 Author: Borio
# unzip file using 7zip.exe on remote machine with session
function Unzip-OnRemoteMachine{
    param(
    	[Parameter(Mandatory=$true)]$Session,
        [Parameter(Mandatory=$true)][string]$archiveFilePath,
        [Parameter(Mandatory=$true)][string]$DestinatinPath
		#,[Parameter(Mandatory=$true)][bool]$DeleteAllFilesBeforeUnzip
    )

	#if ($DeleteAllFilesBeforeUnzip)
	#{
	#	Info "Deleting all files on remote machine $RemoteFilesPath\*.*"
	#	Invoke-Command -Session $Session -ScriptBlock {
	#		Remove-Item -Path $args[0] -force } -ArgumentList "$RemoteFilesPath\*.*"
	#}

	Info "Uncompressing remotelly zip $archiveFilePath to $DestinatinPath"

    $ArgumentsList = "x $archiveFilePath -o$DestinatinPath -aoa -r"

    $Job = Invoke-Command -Session $Session -Scriptblock { 
        param(
            $ArgumentsList = $(throw "Arguments is required")
        )
        
        $pinfo = New-Object System.Diagnostics.ProcessStartInfo
        $pinfo.FileName = "C:\Program Files\7-Zip\7z.exe"
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        $pinfo.Arguments = $ArgumentsList
        $p = New-Object System.Diagnostics.Process
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        echo $p.StandardOutput.ReadToEnd()
        echo $p.StandardError.ReadToEnd()
		
		
		Echo "Job Return Data = " $p.ExitCode


    } -ArgumentList $ArgumentsList -AsJob 
    Wait-Job $Job
    $JobResult = Receive-Job $Job
	
	CheckJobResult $Job $JobResult

	Warn "Uncompressing remotelly finished succesfully"
}

function StopMonitoringService
{
	try
    {
        Info "Stopping service $Global:MonitoringServiceName"
        ServiceJob $Global:MonitoringServiceName 'Stop'
        Warn "$Global:MonitoringServiceName service stopped"
    }
    catch
    {
        Failed "Error transferring files to remote machine! $_.Exception.Message" 
    }
}
function StartMonitoringService
{
	try
    {
        Info "Starting service $Global:MonitoringServiceName"
        ServiceJob $Global:MonitoringServiceName "Start"
        Warn "$Global:MonitoringServiceName service started"
    }
    catch
    {
        Failed "Error transferring files to remote machine! $_.Exception.Message" 
    }
}
function StopServices
{
	try
    {
        Info "Stopping service $Global:ServiceName"
        ServiceJob $Global:ServiceName "Stop"
        Warn "$Global:ServiceName service stopped"
    }
    catch
    {
        Failed "Error transferring files to remote machine! $_.Exception.Message" 
    }
}
function StartServices
{
	try
    {
        Info "Starting service $Global:ServiceName"
        ServiceJob $Global:ServiceName 'Start'
        Warn "$Global:ServiceName service started"
    }
    catch
    {
        Failed "Error transferring files to remote machine! $_.Exception.Message" 
    }
}
function BackupArchiveAndTransfer
{
	param([Parameter(Mandatory=$true)]$ShouldStartStopService,
			[Parameter(Mandatory=$true)]$ShouldStartStopSite
	)

	if ($makeBackup)
    {
        CreateBackup $BackupFile $BackupPath
    }
    Info "Creating archive of $LocalFilesPath files to $LocalFilesPath\$transferZipFileName ..."
    if(Test-Path "$LocalFilesPath\$transferZipFileName")
    {
        Remove-Item "$LocalFilesPath\$transferZipFileName"
    } 
	
	if ($Global:RemoveGlimpse)
	{
		& "C:\Program Files\7-Zip\7z.exe" a -mx=9 "$LocalFilesPath\$transferZipFileName" "$LocalFilesPath\*" -xr!"bin\Glimpse.Ado.dll" -xr!"bin\Glimpse.AspNet.dll" -xr!"bin\Glimpse.Core.dll" -xr!"bin\Glimpse.EF6.dll" -xr!"bin\Glimpse.Mvc5.dll"
	}
	else
	{
		& "C:\Program Files\7-Zip\7z.exe" a -mx=9 "$LocalFilesPath\$transferZipFileName" "$LocalFilesPath\*"
	}
	Warn "Archive created"
        
    Info "Transfering $LocalFilesPath\$transferZipFileName to remote path $RemoteFilesPath ..."
    & Copy-Item -Path "$LocalFilesPath\$transferZipFileName" -Destination $RemoteFilesPath -ToSession $Global:Session -Recurse -Force
	Warn "Transfer to remote machine completed"
       
	StopWindowsServicesIfNeeded $ShouldStartStopService
	StopSiteIfNeeded $ShouldStartStopSite

    Unzip-OnRemoteMachine $Session "$RemoteFilesPath$transferZipFileName" "$RemoteFilesPath" 

	# Copy to RAM drive if any, until the site is stopped
	if ($Global:CopyInRamFolder -and $Global:CopyToServers)
	{
		#copy to local server ram disk
		CopyFolderContentToAnotherServer $remoteFilesPath "\\$Server\$Global:CopyInRamFolder"
	}

	StartSiteIfNeeded $ShouldStartStopSite
	StartWindowsServicesIfNeeded $ShouldStartStopService

    info "deleting zip from local machine $localfilespath\$transferzipfilename"
    remove-item "$localfilespath\$transferzipfilename"
	warn "deleting zip from local machine completed"

	if ($Global:DeleteTransferredArchive)
	{
		info "deleting zip on remote machine $remotefilespath\$transferzipfilename"
		invoke-command -session $Global:Session -scriptblock {
			   remove-item -path $args[0] -force } -argumentlist "$remotefilespath\$transferzipfilename"
		warn "deleting zip on remote machine completed"
	}
}

# 20220509 Volen : Transfer Angular Apps
function TransferApps
{
    Info "Transfering $Global:AngularAppPublishPath\*.zip to remote path $RemoteFilesPath\Downloads\ ..."
    & Copy-Item -Path "$Global:AngularAppPublishPath\*.zip" -Destination $RemoteFilesPath\Downloads\ -ToSession $Global:Session -Force
	Warn "Transfer to remote machine completed"
}

function StopWindowsServicesIfNeeded()
{
	param([Parameter(Mandatory=$true)]$ShouldStartStop)
	if ($ShouldStartStop)
	{
		StopMonitoringService
		StopServices

		# give OS time to release service files
		# it is not perfect solution, but it is very easy
		Warn "Wait 45 seconds OS to release locks on service files"
		Start-Sleep -s 45
	}
}
function StartWindowsServicesIfNeeded()
{
	param([Parameter(Mandatory=$true)]$ShouldStartStop)

	if ($ShouldStartStop)
	{
		StartServices
		StartMonitoringService
	}
}

function StopSiteIfNeeded()
{
	param([Parameter(Mandatory=$true)]$ShouldStartStop)

	if ($ShouldStartStop)
	{
		StopMonitoringService

		Info "Stopping site $Global:SiteName"
		IISRemoteAppCmd "stop apppool /apppool.name:$Global:SiteName"
		#Do
		#{
			
		#	Start-Sleep -s 1
		#	$State = & c:\windows\system32\inetsrv\APPCMD list apppool "$Global:SiteName" /text:State 
		#	Info "$State - Waiting pool to stop ... "
		#}
		#While($State -ne "Stopped")

		#IISRemoteAppCmd "stop site /site.name:$Global:SiteName"
		Warn "$Global:SiteName stopped"		
	}
}
function StartSiteIfNeeded()
{
	param([Parameter(Mandatory=$true)]$ShouldStartStop)
	if ($ShouldStartStop)
	{		
		Info "Starting site $Global:SiteName"
		IISRemoteAppCmd "start apppool /apppool.name:$Global:SiteName"
		#IISRemoteAppCmd "start site /site.name:$Global:SiteName"
		Warn "$Global:SiteName started"
		StartMonitoringService
	}
}

function CopyFoldersContentToAnotherServers
{
	if ($CopyFolder -and $CopyToServers)
	{
		CreateRemoteBuildAndServerTimeStamp $Server $CopyFolder
		Foreach($CopyToServer in $CopyToServers)
		{
			CopyFolderContentToAnotherServer $remoteFilesPath "\\$CopyToServer\$CopyFolder"
			CreateRemoteBuildAndServerTimeStamp $CopyToServer $CopyFolder
		}
	}
	if ($Global:CopyInRamFolder -and $Global:CopyToServers)
	{
		CreateRemoteBuildAndServerTimeStamp $Server $Global:CopyInRamFolder
		
		#20230426 Miro : moved to upzip place, because site is not stopped here and it might failed
		#copy to local server ram disk
		#CopyFolderContentToAnotherServer $remoteFilesPath "\\$Server\$Global:CopyInRamFolder"
		
		Foreach($CopyToServer in $CopyToServers)
		{
			# 20230419 Miro
			# only copy if it is not local machine
			if ($CopyToServer -ne $Server) 
			{
				CopyFolderContentToAnotherServer $remoteFilesPath "\\$CopyToServer\$Global:CopyInRamFolder"
				CreateRemoteBuildAndServerTimeStamp $CopyToServer $Global:CopyInRamFolder
			}
		}
	}
}
function CopyFolderContentToAnotherServer
{
	param([Parameter(Mandatory=$true)][string]$fromFolder, [Parameter(Mandatory=$true)][string]$toFolder)

    #$ArgumentsList =  "/MIR  $fromFolder  $toFolder"
	$ArgumentsList =  "$fromFolder  $toFolder /E /PURGE /XF *.7z"

	Info "Coping files from $fromFolder to $toFolder with arguments: $ArgumentsList...."

	$Job = Invoke-Command  $Server -Authentication CredSSP -Scriptblock { 

            param($ArgumentsList = $(throw "Arguments is required"))
    
            $pinfo = New-Object System.Diagnostics.ProcessStartInfo
            $pinfo.FileName = "robocopy"
            $pinfo.RedirectStandardError = $true
            $pinfo.RedirectStandardOutput = $true
            $pinfo.UseShellExecute = $false
            $pinfo.Arguments = $ArgumentsList
            $p = New-Object System.Diagnostics.Process
            $p.StartInfo = $pinfo
            $p.Start() | Out-Null
            #$p.WaitForExit()
            $p.StandardOutput.ReadToEnd()
            $p.StandardError.ReadToEnd()

			Echo "Job Return Data = " $p.ExitCode

        } -Credential $Cred  -ArgumentList $ArgumentsList -AsJob 

	Wait-Job $Job
    $JobResult = Receive-Job $Job
	#CheckJobResult $Job $JobResult

	Warn "Coping files from $fromFolder to $toFolder completed"
}
# 20181030 Author: Miroslav Braikov
# Remove old backups
function CleanUpOldBackups
{
	if ($BackupFolder)
	{ 
		Info "Deleting backups older than 30 days(if any)"

		Invoke-Command -ComputerName $Server -Authentication CredSSP -command { forfiles /p $args[0] /s /m *.* /D -30 /C "cmd /c del @path" } -Credential $Cred -ArgumentList $BackupFolder

		Warn "Backups older than 30 days(if any) are deleted"
	}
}
# 20181030 Author: Miroslav Braikov
# Check result of remote operation
function CheckJobResult
{
	param([Parameter(Mandatory=$true)]$job, [Parameter(Mandatory=$true)]$JobResult )
	
	if ($Job.State -eq 'Failed')
	{
		Failed $Job.ChildJobs[0].Error
	}

	#$result = ObtainResultAsString $JobResult

	#if ($result -ne "0")
	#{
#		Failed "Job result is '$result'. Expected 0. ($Job.ChildJobs[0].Error)"
#	}
}

function ObtainResultAsString
{
	param([Parameter(Mandatory=$true)]$JobResult)

	$result = "" + $JobResult
    $resultIndex = $result.IndexOf($Global:JobResultMarker)
    if ($resultIndex -ne -1)
    {
        $resultIndex = $resultIndex  + $Global:JobResultMarker.Length
        
		return $result.Substring($resultIndex).Trim()
    }
	return ""
}

#20181028 Author: Miro
# Create timestamp in target folder. If it is web site will be visible in root, buildTime.txt
function CreateRemoteBuildAndServerTimeStamp
{
	param([Parameter(Mandatory=$true)][string]$CopyToServer, [Parameter(Mandatory=$true)][string]$CopyFolder)
	$fileName = ("\\$CopyToServer\$CopyFolder\server.txt")
	Info "Create timestamp in target folder. If it is web site will be visible in root, buildTime.txt"
	$content = $CopyToServer + " " +$mydate
	New-Item $fileName -type File -Force
	Add-Content $fileName $content
	Warn "Timestamp created"
}
#function RestartSiteIfNeeded
#{
#	#if ($false)
#	if ($Global:RestartSiteOnTransfer)
#	{
#		#Import-Module WebAdministration
#		#$siteName = "Default Web Site"
#		#$serverName = "name"
#		#$block = {Stop-WebSite $args[0]; Start-WebSite $args[0]};  

#		#Invoke-Command -Session $session -ScriptBlock $block -ArgumentList $Global:SiteName 

#		#$ArgumentsList = "x $archiveFilePath -o$DestinatinPath -aoa -r"
#		#$ArgumentsList = "stop site /site.name:$Global:SiteName"
#		#$Job = Invoke-Command -Session $Session -Scriptblock { 
#		#	param(
#		#		$ArgumentsList = $(throw "Arguments is required")
#		#	)
        
#		#	$pinfo = New-Object System.Diagnostics.ProcessStartInfo
#		#	$pinfo.FileName = "C:\Windows\System32\inetsrv\appcmd.exe"
#		#	$pinfo.RedirectStandardError = $true
#		#	$pinfo.RedirectStandardOutput = $true
#		#	$pinfo.UseShellExecute = $false
#		#	$pinfo.Arguments = $ArgumentsList
#		#	$p = New-Object System.Diagnostics.Process
#		#	$p.StartInfo = $pinfo
#		#	$p.Start() | Out-Null
#		#	echo $p.StandardOutput.ReadToEnd()
#		#	echo $p.StandardError.ReadToEnd()

#		#} -ArgumentList $ArgumentsList -AsJob 
#		#Wait-Job $Job
#		#Receive-Job $Job
	
#		#CheckJobResult $Job
#		Info "Stopping site $Global:SiteName"
#		AppCmd "stop site /site.name:$Global:SiteName"

#		Info "Starting site $Global:SiteName"
#		AppCmd "start site /site.name:$Global:SiteName"
#		#C:\Windows\System32\inetsrv\appcmd.exe start site /site.name:test.loggedin.io
#	}
	
#}
function IISRemoteAppCmd
	{
		param($ArgumentsList = $(throw "Arguments is required"))
		
		$Job = Invoke-Command -Session $Session -Scriptblock { 
			param(
				$ArgumentsList = $(throw "Arguments is required")
			)
        
			$pinfo = New-Object System.Diagnostics.ProcessStartInfo
			$pinfo.FileName = "C:\Windows\System32\inetsrv\appcmd.exe"
			$pinfo.RedirectStandardError = $true
			$pinfo.RedirectStandardOutput = $true
			$pinfo.UseShellExecute = $false
			$pinfo.Arguments = $ArgumentsList
			$p = New-Object System.Diagnostics.Process
			$p.StartInfo = $pinfo
			$p.Start() | Out-Null
			echo $p.StandardOutput.ReadToEnd()
			echo $p.StandardError.ReadToEnd()
		
			Echo "Job Return Data = " $p.ExitCode

		} -ArgumentList $ArgumentsList -AsJob 
		Wait-Job $Job
		$JobResult = Receive-Job $Job
	
		CheckJobResult $Job $JobResult
	}
