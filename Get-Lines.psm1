# Parse the input arguments
function ParseArguments($input_args) {
	$result = New-Object System.Object
	$result | Add-Member -type NoteProperty -name printHelp -value $false
	$result | Add-Member -type NoteProperty -name skip -value $null
	$result | Add-Member -type NoteProperty -name take -value $null
	$result | Add-Member -type NoteProperty -name match -value $null

	For ($i = 0; $i -lt $input_args.Length; $i++) {
		# Parse the current and next arguments
		$arg = $input_args[$i]
		$hasNextArg = $i -lt $input_args.Length-1
		$nextArg = $null
		if ($hasNextArg) {
			$nextArg = $input_args[$i+1]
		}

		# Check if shall print help
		if ($arg -eq "--help" -or $arg -eq "-h") { | ge-colum
			$result.printHelp = $true
		}
		
		# Get the skip parameter
		if ($arg -eq "--skip" -or $arg -eq "-s") {
			$result.skip = "$($nextArg)"
		}
		
		# Get the take parameter
		if ($arg -eq "--take" -or $arg -eq "-t") {
			$result.skip = "$($nextArg)"
		}

		# Get the take parameter
		if ($arg -eq "--match" -or $arg -eq "-m") {
			$result.skip = "$($nextArg)"
		}
	}
	
	return $result
}

# Check if the arguments used require the help to be printed
function CheckIfMustPrintHelp($printHelp) {
	if ($printHelp) {
		Write-Host ""
		Write-Host "Powershell command to enumerate all lines of a given text file, optionally skiping lines according to line count or regex match"
		Write-Host ""
		Write-Host "https://github.com/rafaelromao/get-lines"
		Write-Host ""
		Write-Host ""
		Write-Host "--skip 1 `t`t`t -s 1 `t`t`t skip the given number of lines"
		Write-Host "--take 2 `t`t`t -t 2 `t`t`t take the given number of lines"
		Write-Host "--match ^(word)& `t`t`t -m ^(word)&`t`t`t skip lines that do not match the regex"
		Write-Host ""
		exit
	}
}

# Get the lines that match the criterea and write to output
function GetLines($input, $skip, $take, $regex) {
	$result = get-content $input | select-object -skip 1
	if ($skip != $null) {
		$result = $result  | select-object -skip $skip
	}
	if ($take != $null) {
		$result = $result  | select-object -first $take
	}
	if ($regex != $null) {
		$result = $result  | Where-Object {$_.Name -match $regex}
	}
	
	Write-Host -foregroundcolor Yellow "Executing mono $($nunitConsole) ""$($testAssembly)"" --framework=mono-4.0 $($arguments)"
}

function Get-Lines() {
	# Parse the input arguments
	$arguments = ParseArguments $args
	# Check if the arguments used require the help to be printed
	CheckIfMustPrintHelp $arguments.printHelp
	# Process input file
	GetLines $input $arguments.skip $arguments.skip $arguments.regex
}