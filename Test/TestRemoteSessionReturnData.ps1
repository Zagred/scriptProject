# Currently, even if unzip and zip operations failed (failed to overwrite files for example) job return "completed" 
# this is a test to get and return result from 7z and also to return output of it (both thing)

$Global:Server = "usdn1"
$Global:branchFolder = @("D:\Projects\Trunk")

$rootPath  = (Get-Item $PSScriptRoot).Parent.FullName

. "$rootPath\Common\CommonVariables.ps1"

InitSession $Server

$BackupFile = "c:\temp\test.7z"
$RemoteFilesPath = "C:\temp\TreeSizeFree\k"

$ArgumentsList = "a -y -r -xr!*.7z -xr!*.zip -xr!Data\*.* $BackupFile $RemoteFilesPath"

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
        #Echo "Job Return Data = " $p.ExitCode + ", Last error = " + $lastErrorCode;
		

        #$LASTEXITCODE
        Echo "Job Return Data = " $p.ExitCode

    } -ArgumentList $ArgumentsList -AsJob 
    Wait-Job $Job
    #$r = Receive-Job -wait $Job
	$r = Receive-Job $Job
    $result = "" + $r
    #Wait-Job $Job
	#Echo $job
    $resultIndex = $result.IndexOf("Job Return Data = ")
    if ($resultIndex -ne -1)
    {
        $resultIndex = $resultIndex  + "Job Return Data = ".Length
        $resultStr = $result.Substring($resultIndex).Trim()
    }
    

    
    Write-Host $result -ForegroundColor Green

	Remove-PSSession -Session $Session