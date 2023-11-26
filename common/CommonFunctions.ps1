﻿# ------------------------------------------------------------------------------------------------------------------
# Borio 20151111
# Miro & Borio 20170321 
# Miro 10181022 Restructure variables and functions
# ------------------------------------------------------------------------------------------------------------------


$scriptPath  = (Get-Item $PSScriptRoot).FullName
. "$scriptPath\Logging.ps1"

# 20181022 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function PublishHtmlSite()
{
	ShowVariables

	if ($Global:UseSession)
	{
		InitSession $Server
	}


	try
	{
		CheckoutUpdateSourceControl

		CreateBuildTimeStamp
		
		BackupArchiveAndTransfer $false $Global:RestartSiteOnTransfer

		# if you need that define $Global:BackupFolder
		CleanUpOldBackups

		SuccessFinished "Transfer completed succesfully"
	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}
# 20181022 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function PublishSite()
{
	ShowVariables
	if ($Global:UseSession)
	{
		InitSession $Server
	}
	try
	{
		CheckoutSolution 
		
		PublishProject 

		# will build angular if there is such
		BuildAndPublishAngularIfNeeded
		
		BackupArchiveAndTransfer $false $Global:RestartSiteOnTransfer

		if ($fromPictures -and $toPictures)
		{
			TransferMediaSitePictures $fromPictures $toPictures
		}

		if($Global:AngularAppPublishPath)
		{
			TransferApps
		}

		# if you need that, define $Global:CopyFolder and $Global:CopyToServers
		CopyFoldersContentToAnotherServers
		# if you need that define $Global:BackupFolder
		CleanUpOldBackups

		SuccessFinished "Transfer completed succesfully"
	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}

# 20220509 Volen : Publish Angular Apps
function PublishApps()
{
	ShowVariables

	InitSession $Server

	try
	{
		CheckoutSolution 
		
		BuildAndPublishAngularIfNeeded
		TransferApps

		# 20221108 Volen: copy apps to ramdrive & servers
		$remoteFilesPathOriginal = $remoteFilesPath 
		# change $remoteFilesPath so only the apps folder is copied to servers.
		$remoteFilesPath = "$remoteFilesPath\Downloads\"
		# if you need that, define $Global:CopyFolder and $Global:CopyToServers
		CopyFoldersContentToAnotherServers
		# restore $remoteFilesPath
		$remoteFilesPath = $remoteFilesPathOriginal 

		SuccessFinished "Transfer completed succesfully"
	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}


function BuildAndPublishAngularIfNeeded()
{
	if (!$Global:AngularProjectPath){ return }
	if (!$Global:AngularConfiguration){ return }
	if (!$Global:AngularPublishPath -and !$Global:AngularAppPublishPath){ return }


    try
    {    		
		Info "Building $Global:AngularProjectPath project"
		Set-Location $Global:AngularProjectPath
		& npm install
		$npmCommand = "build"
		if ($Global:AngularPublishPath) { $npmCommand += "-web" }
		if ($Global:AngularAppPublishPath) { $npmCommand += "-app" }
		Info "Building angular command line: & npm run $npmCommand --env=$Global:AngularConfiguration"
		& npm run $npmCommand --env=$Global:AngularConfiguration
		Warn "Angular part is builded"
		if ($?)
		{
			# 20220509 Volen : done in $npmCommand
			### !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			### this command binds function to uncut project, so if we use it for other projects in future it will need modifications
			##& move dist\\app\\index.html dist\\app\\uncut.html

			# 20220509 Volen : Publish Angular Site if needed
			if ($Global:AngularPublishPath)
			{
				Info "Moving $Global:AngularProjectPath\dist\app $Global:AngularPublishPath"
				& move dist\\app $Global:AngularPublishPath
			}
			# 20220509 Volen : Publish Angular Apps if needed
			if ($Global:AngularAppPublishPath)
			{
				$source = $Global:AngularProjectPath + "dist-nw\" + $Global:AngularConfiguration + "\*.zip"
				Info "Moving $source $Global:AngularAppPublishPath"
				$oldFiles = $Global:AngularAppPublishPath + "*.zip"
				& md   $Global:AngularAppPublishPath
				& del  $oldFiles
				& move $source $Global:AngularAppPublishPath
			}
		}
        CheckResult "Build angular Failed"
        Warn "Angular project build successfully!"
    }
    catch
    {
        Failed "Error: Cannot build solution $_.Exception.Message"
    }
}

# 20181022 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function PublishMedia()
{
	ShowVariables

	InitSession $Server

	try
	{
		CheckoutSolution 

		TransferMediaSitePictures $fromPictures $toPictures

		# if you need that, define $Global:CopyFolder and $Global:CopyToServers
		CopyFoldersContentToAnotherServers

		SuccessFinished "Transfer completed succesfully"
	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}

# 20181023 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function PublishWindowsService()
{
	ShowVariables

	InitSession $Server

	try
	{
		CheckoutSolution 
		BuildSolution 
        BackupArchiveAndTransfer $true $false
		
		SuccessFinished "Transfer completed succesfully"
 	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}

# 20181023 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function PublishProcessors()
{
	ShowVariables
	
	InitSession $Server

	try
	{
        CheckoutSolution 
		BuildSolution 
		
		#DisableShoogerProcessorsTasks
        
		BackupArchiveAndTransfer $false $false
        
		SuccessFinished "Transfer completed succesfully"
 	}
	catch
	{
		Failed $_.Exception.Message
	}
	finally
	{
		#EnableShoogerProcessorsTasks
		Remove-PSSession -Session $Session
	}
	#CleanupVariables
}

# 20181022 Author: Miroslav Braikov
# Get latest version of solution from specific svn branch
function CheckoutSolution()
{
	CheckoutUpdateSourceControl 
	RestoreNugetPackages
}

function PublishProject()
{
	CleanupPublishFolder 

	if (!$localFilesPath){ Error "Error in PublishProject: localFilesPath need to be set as global parameter"; Exit 1;}
	if (!$projectBuildFile){ Error "Error in PublishProject: projectBuildFile need to be set as global parameter"; Exit 1;}
	if (!$projectPublishProfile){ Error "Error in PublishProject: projectPublishProfile need to be set as global parameter"; Exit 1;}
	if (!$configuration){ Error "Error in PublishProject: configuration need to be set as global parameter"; Exit 1;}

	Info "Publishing.... $Global:msbuild $projectBuildFile /m:4 /nr:false /p:Configuration=$configuration /p:Platform=AnyCPU /p:DeployOnBuild=true /p:PublishProfile=$projectPublishProfile /verbosity:quiet /p:WarningLevel=0"      
	# hanging on ms build, after build is finished
	#https://stackoverflow.com/questions/13510465/the-mystery-of-stuck-inactive-msbuild-exe-processes-locked-stylecop-dll-nuget
	& $Global:msbuild $projectBuildFile /m:4 /nr:false /p:Configuration=$configuration  /p:DeployOnBuild=true /p:PublishProfile=$projectPublishProfile /verbosity:quiet /p:WarningLevel=0 /p:RunCodeAnalysis=false /p:CodeAnalysisRuleSetDirectories="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Team Tools\Static Analysis Tools\Rule Sets"
    CheckResult "FileSystem publish failed"
    
	CreateBuildTimeStamp

	if  ($Global:UpdateCss)
	{
		Info ("Updating CSSVersion in " + $Global:UpdateCss)

		& $updateCssVesion $Global:UpdateCss
		
		Info "Updating CSSVersion updated"
	}

    Warn "File system publishing finished successfully!"
}


# 20181023 Author: Miroslav Braikov
# Remove everything from publish folder
function CleanupPublishFolder()
{
	if (!$Global:localFilesPath){ Error "Error in CleanupPublishFolder: Global:localFilesPath need to be set as global parameter"; Exit 1;}

    Info "Remove all files from publish folder $localFilesPath ..." 
    if([System.IO.Directory]::Exists($Global:localFilesPath))
	{
		Remove-Item ($Global:localFilesPath + "\*") -Recurse -Force
		Warn "Publish folder is clear"
	}
}

function CheckoutUpdateSourceControl()
{
	if (!$branchFolder){ Error "Error in CheckoutUpdateSourceControl: branchFolder need to be set as global parameter"; Exit 1;}
	if (!$svnRepoPath){ Error "Error in CheckoutUpdateSourceControl: svnRepoPath need to be set as global parameter"; Exit 1;}
    Try
    {
		if (-not $svnRepoPath.Length -eq $branchFolder.Length)
		{
			Failed "$svnRepoPath and $branchFolder have different lenght"
		}
		for ($i=0; $i -lt $svnRepoPath.length; $i++) 
		{
			$svn = $svnRepoPath[$i]
			$folder = $branchFolder[$i]

			# checkout SVN repo if clonePath is empty
			if(![System.IO.Directory]::Exists($folder) -or (dir $folder).count -eq 0)
			{
				Info "Checking out SVN Repository $svn to $folder"
				& $svnPath checkout $svn $folder --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive
				CheckResult  "Cannot checkout project"
			
				Warn "Checkikng out SVN Repository finished successfully"
			}
			else
			{
				Info "Updating SVN Repository $svn / $folder"
				if ($global:Revision)
				{
					# 20220804 Miro : not sure what will happen if revision does not exsist i.e. updating uncut to version, but also we are getting 
					# libraries from other repo, and the revision might not exists or even worse, it could be wrong
					#
					# so revision should be moved to $svnRepoPath !!!
					#
					& $svnPath update $folder -r $global:Revision --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive
				}
				else
				{
					& $svnPath update $folder --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive
				}
				
				
				CheckResult   "Cannot checkout project"
				Warn "Updating SVN Repository finished successfully"
			}
		}
    }
    Catch
    {    
        Failed "Error trying to checkout/update project $_.Exception.Message"
    }
}

function RestoreNugetPackages()
{
    #param([Parameter(Mandatory=$true)][string]$solutionFile)
	if (!$solutionBuildFile){ Error "Error in RestoreNugetPackages: solutionBuildFile need to be set as global parameter"; Exit 1;}
	
	try
	{
		Info "Restoring nuget packages for $solutionBuildFile"  
		& $nugetPath restore $solutionBuildFile -configfile $nugetConfig
		CheckResult   "Cannot ?estor? nuget packages for $solutionBuildFile"

		Warn "Restoring nuget packages finished successfully" 
  }
  Catch
  {
      Failed "Error trying to update nuget packages $_.Exception.Message"
  }
}

function BuildSolution()
{
	if (!$solutionBuildFile){ Error "Error in BuildSolution: solutionBuildFile need to be set as global parameter"; Exit 1;}
	if (!$buildCommandParams){ Error "Error in BuildSolution: buildCommandParams need to be set as global parameter"; Exit 1;}
    try
    {    		
		Info "Building.... $Global:msbuild  $solutionBuildFile $buildCommandParams /m:4 /nr:false /verbosity:quiet /m /t:Rebuild /p:WarningLevel=0 /p:nowarn=3277 /p:RunCodeAnalysis=false  /p:CodeAnalysisRuleSetDirectories=C:\Program Files (x86)\Microsoft Visual Studio 14.0\Team Tools\Static Analysis Tools\Rule Sets"      

        & $msbuild $solutionBuildFile $buildCommandParams /m:4 /nr:false /verbosity:quiet /m /t:Rebuild /p:WarningLevel=0 /p:nowarn=3277 /p:RunCodeAnalysis=false  /p:CodeAnalysisRuleSetDirectories="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Team Tools\Static Analysis Tools\Rule Sets"
        CheckResult "Build $solutionBuildFile Failed"

		CreateBuildTimeStamp
        Warn "Solution build successfully!"
    }
    catch
    {
        Failed "Error: Cannot build solution $_.Exception.Message"
    }
}

#20181026 Borio
#20200513 Miro: Cleanup
# Transfer media site pictures only
function TransferMediaSitePictures()
{
	param
	(
	    [Parameter(Mandatory=$true)][string]$from,
	    [Parameter(Mandatory=$true)][string]$to
	)

	try
	{		
		CheckoutSolution 

		Foreach($item in $MediaFolders)
		{
			robocopy "$from\$item" "$to\$item" /XF *.css /XO /J /SL /S /MT:8 /R:1 /W:1 /V /DCOPY:DT /ETA /COPY:DT /FFT /XD $RECYCLE.BIN "System Volume Information"
			Info "Copying from $from\$item to $to\$item ....DONE"
		}
	}
	catch
	{
		Failed "Error: copying pictures failed: $_.Exception.Message"
	}
	finally
	{
		#Remove-PSSession -Session $Session
	}
}

#20181028 Author: Miro
# Create timestamp in target folder. If it is web site will be visible in root, buildTime.txt
function CreateBuildTimeStamp
{
	if ($Global:DotnetCoreProject)
	{
		$fileName = ($localFilesPath + "\wwwroot\buildTime.txt")
	}
	else
	{
		$fileName = ($localFilesPath + "\buildTime.txt")
	}

	Info "Create timestamp in target folder. If it is web site will be visible in root, buildTime.txt"
	New-Item $fileName -type File -Force
	Add-Content $fileName $mydate
	Warn "Timestamp created"
}

#20181030 Author: Borio
# 1.Delete specified branch '$svnBranchPath' branch
# 2.Create/copy new branch from specified '$svnSourcePath' 
function DeleteBranchAndCreateNew()
{
	param(
    [Parameter(Mandatory=$true)][string]$svnRootBranchPath, 
    [Parameter(Mandatory=$true)][string]$svnBranchPath,
    [Parameter(Mandatory=$true)][string]$svnSourcePath)

	Try
    {
		Info "Deleting SVN branch $svnBranchPath ..."
		& $svnPath rm $svnBranchPath --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive -m 'Deleteing branch'
		CheckResult "Deleting SVN branch $svnBranchPath Failed"
		Warn "Deleting SVN branch finished successfully !!!"

		# perform svn update so that local copy can detect deleted branch
        Info "Updating svn local copy of branch $svnBranchPath ..."
        & $svnPath update $svnRootBranchPath --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive
		CheckResult "Updating local svn copy failed!"
            
		Info "Creating new SVN branch $svnBranchPath copy from $svnSourcePath ..."
		& $svnPath copy $svnSourcePath $svnPreLifeBranchPath --no-auth-cache --non-interactive -m 'Creating new branch'
		CheckResult "Creating new SVN branch $svnBranchPath copy from $svnSourcePath Failed"
		Warn "Creating new SVN branch finished successfully !!!"

		# perform svn update so that local copy can get newly created branch
        Info "Updating svn local copy of branch $svnBranchPath ..."
        & $svnPath update $svnRootBranchPath --username $svnUsername --password $svnPassword --no-auth-cache --non-interactive
		CheckResult "Updating local svn copy failed!"

		Warn "!!! DeleteBranchAndCreateNew finished successfully !!!"
    }
    Catch
    {    
        Failed "Error trying to delete/create branch $svnBranchPath $_.Exception.Message"
    }
}

#20181031 Borio & Jani
#If we import Powershell SqlServer module on build server we could use built-in cmdlets e.g
#Invoke-Sqlcmd -ServerInstance "BGSVN01\Test" -Database "Shooger" -Query "exec bo.Dispite_GetFiles 302"
function ExecuteStoredProcedure() 
{
    param(
    [Parameter(Mandatory=$true)][string]$connectionString, 
    [Parameter(Mandatory=$true)][string]$commandText,
    [Parameter(Mandatory=$false)][hashtable]$commandParams,
    [Parameter(Mandatory=$false)][long]$timeOut)

    try
    {
        $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
        $SqlConnection.ConnectionString = $connectionString
        $SqlConnection.Open()

        $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
        $SqlCmd.Connection = $SqlConnection
        
        if($timeOut)
        {
            $sqlcmd.CommandTimeout = $timeOut
        }
      
        $SqlCmd.CommandType=[System.Data.CommandType]::'StoredProcedure'        
        $SqlCmd.CommandText = $commandText

        if($commandParams)
        {
            foreach($item in $commandParams.GetEnumerator()) 
            {
                $SqlCmd.Parameters.AddWithValue("@$($item.Name)",[string]$item.Value).Direction = [System.Data.ParameterDirection]::Input
            }  
        }

        $SqlCmd.ExecuteNonQuery()
        $SqlConnection.Close()
    }
    catch
    {
        Failed "Error trying to execute stored procedure $commandText" 
    }
}

# 20181022 Author: Miroslav Braikov
# Check result of remote operation
function CheckResult
{
	param([Parameter(Mandatory=$true)][string]$error )
	
    if (-not ($LASTEXITCODE -eq 0))
    {
        Failed $error
		Exit 1
    }
}

#201902118 Author: Kliment Nikoloski
# This function is disabling remote tasks on usdn2 and decrease potential transfer collisions.
function DisableShoogerProcessorsTasks
{
	##### SHOOGER TASKS DISABLE #######
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every 8 hours actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\BotDetection - Everyday actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Call Tracking - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\BusinessesSearchesGeocode-Every-hour-actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Database - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Database - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every week actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Emails - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Emails-Every-hour-actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - Common - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - Facebook - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - GoogelMyBusiness - Every hour actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - MyRepMan - Every 5 minutes actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - MyRepMan - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Facebook - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\GoogleMyBusiness - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Imports - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Imports - Every suturday actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Leads-Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\LeadsExport-Every 1 minute actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every two hours actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every week actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Lucene - Every Day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Every Day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Every Hour Actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Publish reviews" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Generate App Notifications" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Update Campaign Schedules" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Send Download Merchant App One Week" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - User package related, payment generation and payment processing" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SEO - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SEO - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SitemapSubmition - Every hour actions" /DISABLE
}
#201902118 Author: Kliment Nikoloski
# This function is disabling remote tasks on usdn2 and decrease potential transfer collisions.
function DisableUsdProcessorsTasks
{
	##### USD TASKS DISABLE #######
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every 8 hours actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\BotDetection - Everyday actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\BusinessesSearchesGeocode-Every-hour-actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Call Tracking - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Database - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Database - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every week actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Emails-Every-hour-actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - Common - Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - Facebook - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - GoogelMyBusiness - Every hour actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - MyRepMan - Every 5 minutes actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - MyRepMan - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Facebook - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every two hours actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every week actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Lucene - Every Day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Leads-Every 5 minutes actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Every Day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Every Hour Actions" /DISABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Publish reviews" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Generate App Notifications" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Update Campaign Schedules" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Speedchex Status Update" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Send Download Merchant App One Week" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - User package related, payment generation and payment processing" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SEO - Every day actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SEO - Every hour actions" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SitemapSubmition - Every hour actions" /DISABLE
}
#201902118 Author: Kliment Nikoloski
# This function is enabling remote tasks on usdn2 and decrease potential transfer collisions.
function EnableShoogerProcessorsTasks
{
	##### SHOOGER TASKS ENABLE #######
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every 8 hours actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Adwords - Every day actions" /ENABLE
	#20190701 Miro: we do not make bot detection for now
	#schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\BotDetection - Everyday actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Call Tracking - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\BusinessesSearchesGeocode-Every-hour-actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Database - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Database - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\DataMonitoring - Every week actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Emails - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Emails-Every-hour-actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - Common - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - Facebook - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - GoogelMyBusiness - Every hour actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - MyRepMan - Every 5 minutes actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\ExternalReviews - MyRepMan - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Facebook - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\GoogleMyBusiness - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Imports - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Imports - Every suturday actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every two hours actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Locations - Every week actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Lucene - Every Day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Leads-Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\LeadsExport-Every 1 minute actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Every Day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Every Hour Actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Publish reviews" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Generate App Notifications" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Update Campaign Schedules" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - Send Download Merchant App One Week" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\Merchant - User package related, payment generation and payment processing" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SEO - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SEO - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Shooger\SitemapSubmition - Every hour actions" /ENABLE

}

#201902118 Author: Kliment Nikoloski
# This function is enabling remote tasks on usdn2 and decrease potential transfer collisions.
function EnableUsdProcessorsTasks
{
	##### USD TASKS ENABLE #######
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every 8 hours actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Adwords - Every day actions" /ENABLE
	#20190701 Miro: we do not make bot detection for now
	#schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\BotDetection - Everyday actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Call Tracking - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\BusinessesSearchesGeocode-Every-hour-actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Database - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Database - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\DataMonitoring - Every week actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Emails-Every-hour-actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - Common - Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - Facebook - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - GoogelMyBusiness - Every hour actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - MyRepMan - Every 5 minutes actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\ExternalReviews - MyRepMan - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Facebook - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every two hours actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Locations - Every week actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Lucene - Every Day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Leads-Every 5 minutes actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Every Day actions" /ENABLE	
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Every Hour Actions" /ENABLE
#	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Publish reviews" /DISABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Generate App Notifications" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Update Campaign Schedules" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Speedchex Status Update" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - Send Download Merchant App One Week" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\Merchant - User package related, payment generation and payment processing" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SEO - Every day actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SEO - Every hour actions" /ENABLE
	schtasks /change /s usdn2.corp.shooger.com /tn "\Usd\SitemapSubmition - Every hour actions" /ENABLE
}

function InitSession
{
	param([Parameter(Mandatory=$true)][string]$Server)

	Info "Init session to $Server"

	$Global:Cred = new-object -typename System.Management.Automation.PSCredential -Argumentlist $username, $password
	$Global:Session = New-PSsession -ComputerName $Server -credential $Cred

	if (!$Global:Session)
	{
		Failed "Cannot create session to remote server $Server"
	}
}
#20200512 Miro : Show all defined variables
# Usage In beginning of the script put $AutomaticVariables = Get-Variable
# Then the you want to see all variables call the function
function ShowVariables 
{
	if ($AutomaticVariables)
	{
		Compare-Object (Get-Variable) $AutomaticVariables -Property Name -PassThru | Where -Property Name -ne "AutomaticVariables"
	}
	else
	{
		Write-Host "Need $$AutomaticVariables = Get-Variable in the beginning of the script"
	}
}
#20200512 Miro : Clear all defined variables. 
# Note: only variables after $AutomaticVariables = Get-Variable will be cleared
function CleanupVariables
{
	Info "CleanupVariables ... "
	$i = 0
	Foreach($item in ShowVariables)
	{ 
		$i = $i + 1
		if ($item.Name -ne "i")
		{
			Remove-Variable -Scope Global -Name $item.Name
		}
	}

	Info "$i variables destroyed"
}