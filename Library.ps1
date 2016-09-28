<#
.SYNOPSIS
Copies with Robocopy

.EXAMPLE
Copy-Robocopy -Source $RemoteVMs -Destination $LocalVMs -Progress

.PARAMETER Source
Source

.PARAMETER Destination
Destination

.PARAMETER Progress
If set, show Robocopy output
#>
Function Copy-Robocopy($Source, $Destination, [switch]$Progress)
{
	If($Progress)
	{
		Start-Process -FilePath "Robocopy.exe" -ArgumentList "`"$Source`" `"$Destination`" /MIR" -NoNewWindow -Wait
	}
	Else
	{
		Start-Process -FilePath "Robocopy.exe" -ArgumentList "`"$Source`" `"$Destination`" /MIR" -WindowStyle hidden -Wait
	}
}


<#
.SYNOPSIS
Pause the script (was not included prior to Powershell 3.0)

.EXAMPLE
Pause-Script

.EXAMPLE
Pause-Script -PauseMessage "This script is done"

.PARAMETER PauseMessage
Message to the user (only shown if version is lower than 3)

.PARAMETER Exit
If set, exits after the Pause
#>
Function Pause-Script($PauseMessage = "Press any key to continue ...",[switch]$Exit)
{
    # This does not work on PS1 as reported on StackOverflow; however this is not an issue since we are using V2 upwards
	If($PSVersionTable.PSVersion.Major -lt 3)
	{
	   Write-Host $PauseMessage
	   $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	}
	Else
	{
		Pause
	}
	
	If($Exit)
	{
		Exit
	}
}
<#
.SYNOPSIS
Test if a directory exists, if not, create it

.EXAMPLE
$DistributionBundles = "$Bundle\core\distribution\bundles"
TestCreate-Directory -Dir $DistributionBundles

.PARAMETER Dir
Directory to test

.PARAMETER Message
Show a message to the user if needed or not
#>
Function TestCreate-Directory($Dir,[switch]$Message)
{
	If(-not(Test-Path $Dir))
	{
		If($Message)
		{
			Write-Host "$Dir not found, creating..."
		}
		New-Item -Path $Dir -ItemType directory | Out-Null
	}
	Else
	{
		If($Message)
		{
			Write-Host "$Dir found"
		}
	}
}


<#
.SYNOPSIS
Test if a file or directory exists. If not, show a message, pause and exit

.EXAMPLE
$SourceDir="..\..\..\source\windows"
TestMessage-Path -Path $SourceDir -Type "Source directory"

.PARAMETER Path
File or directory to test

.PARAMETER Type
Type of item (needed for message)

.PARAMETER Recovery
What to do, if it is not found (optional parameter)

.PARAMETER Message
Show a message, if it is found
#>
Function TestMessage-Path($Path, $Type, $Recovery, [switch]$Message)
{
	If(!(Test-Path $Path))
	{
		Write-Host "$Type $Path not found" -ForegroundColor Red
		Write-Host $Recovery
		Pause-Script -Exit
	}
	Else
	{
		If($Message)
		{
			Write-Host "$Type $Path was found"
		}
	}
}

<#
.SYNOPSIS
Show the current step in yellow

.EXAMPLE
Write-Step -Step 1 -Message "Checking requirements"

.PARAMETER Step
Number of step

.PARAMETER Message
Message to show
#>
Function Write-Step($Step, $Message)
{
	Write-Host "`nStep ${step}: $Message`n" -ForegroundColor Yellow
}

<#
.SYNOPSIS
Show success in green
If message is given, write it
Else, just write a generic success message

.EXAMPLE
Write-Step -Step 1 -Message "Checking requirements"

.PARAMETER Message
Message to show, if needed
#>
Function Write-Success($Message)
{
	$SuccessMessage = "Success"
	If($Message)
	{
		$SuccessMessage += ": $Message"
	}
	Else
	{
		$SuccessMessage += "ful"
	}
	Write-Host "$SuccessMessage" -ForegroundColor Green
}