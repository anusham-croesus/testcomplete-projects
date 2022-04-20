#Valeurs par defaut des parametres
$Script:WinSessionPassword 		= "T.auto2012";
$Script:VServerPassword 		= "TestsAuto2019!!";
$Script:Master 					= "qaapp1";
$Script:Platform 				= "autoref";
$Script:DatabaseServer 			= "qatestauto1bd";
$Script:DumpFileDirectory 		= "/var/lib/sybase/backup/BDRef";
$Script:SuccessReturnCode 		= "SUCCESS";
$Script:DevOpsDeploymentFilePath= "C:\s-backup\QA Tests\TestCompleteProjects20207\ProjectSuitesCommonScripts\DevOps\ReleaseFoundations\current\ReleaseFoundations.psm1";



function ImportModuleReleaseFoundations
{
	$DevOpsDeploymentFilePath = $Script:DevOpsDeploymentFilePath
	
    Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
    if (!$?){
        Write-Host "There was an issue while executing : Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force";
        throw $Error[0];
    }
	
    Import-Module $DevOpsDeploymentFilePath -Force
    if (!$?){
        throw "There was an issue while executing : Import-Module $($DevOpsDeploymentFilePath) -Force";
    }
}



function RemoveModuleReleaseFoundations
{
	$DevOpsDeploymentFilePath = $Script:DevOpsDeploymentFilePath
	
    try {
        if ($null -ne $(Get-Module -Name (Get-Item $DevOpsDeploymentFilePath).BaseName)){
            Remove-Module (Get-Item $DevOpsDeploymentFilePath).BaseName -Force;
        }
        #Set-ExecutionPolicy Undefined -Scope CurrentUser -Force;
    }
    catch {
		Write-Host "$_";
    }
}



<#
.SYNOPSIS
Donne la liste des noms des noms de references.

.DESCRIPTION

.OUTPUTS
String : Liste des noms de references (un par ligne).

.EXAMPLE 
PS> GetReferenceNames
#>
function GetReferenceNames
{
	try {
		#Clear;
		#$Error.Clear();
		$returnResultString = "";
		$warningMsg = "";
		
		Write-Host "`nGet Reference Names list`n--------------------------------------------------------";
		
		ImportModuleReleaseFoundations;
		
		#Get all References object
		$objReferences = $null;
		$objReferences = Get-Reference
		
		if ($objReferences -eq $null){
			throw "There was an issue while getting References object.";
		}
		
		#Retrieve Reference Names list
		[String[]] $arrayOfReferenceName = @();
		if ($objReferences.Count -eq 0){
			$warningMsg = "$($warningMsg) No ReferenceName retrieved.";
		}
		else {
			foreach ($objReference in $objReferences){
				$arrayOfReferenceName += $objReference.Name;
			}
		}
		
		#Return ReferenceNames list as String
		$returnResultString = $arrayOfReferenceName -join "`n";
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



function GetHttpError
{
	[OutputType([System.String])]
	Param([Parameter(Mandatory=$true, Position=0)]$webServerResponse)
	
	#For result success check
	$httpSuccessCode = 200;
	$httpErrorMsg = "";
	
	#Check Web Server Response HTTP status code
	if (-not ($webServerResponse.StatusCode -eq $httpSuccessCode -and ($webServerResponse.Headers.Status -eq $null -or $webServerResponse.Headers.Status -eq $httpSuccessCode))){
		$httpErrorMsg = "WebRequest http StatusCode = $($webServerResponse.StatusCode)"
		if ($webServerResponse.Headers.Status -ne $null){
			if ($httpErrorMsg -ne ""){
				$httpErrorMsg = "$($httpErrorMsg) and";
			}
			$httpErrorMsg = "$($httpErrorMsg) http Headers.Status = $($webServerResponse.Headers.Status)"
		}
		$httpErrorMsg = "$($httpErrorMsg) not matching expected http status = $($httpSuccessCode).";
	}
	
	return $httpErrorMsg;
}




<#
.SYNOPSIS
Donne la liste des noms des dumps d'un dossier de depot de dumps.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles DatabaseServer (facultative), DumpFileDirectory (facultative), WinSessionPassword (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER DumpFileDirectory
Specifie le dossier de depot du dump (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.OUTPUTS
String : Liste des noms des dumps (un par ligne).

.EXAMPLE 
PS> GetDumpFileNames -DatabaseServer "qatestauto1bd" -DumpFileDirectory "/var/lib/sybase/backup/BDRef"
#>
function GetDumpFileNames
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpFileDirectory = $Script:DumpFileDirectory,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword
	)
	
	try {
		#Parameters
		Write-Host
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$DumpFileDirectory = "/" + "$DumpFileDirectory".Trim("/");
		
		#Execute Dumps Get WebRequest
		Write-Host "Get directory $($DumpFileDirectory) Dumps list from DataBase server $($DatabaseServer) ...";
		$DatabaseServerDumpsWebPageUrl = "https://$($DatabaseServer).croesus.local/sybadm/?mode=dumps&dir=$($DumpFileDirectory)";
		$webServerDumpsGetResponse = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$webServerDumpsGetResponse = Invoke-WebRequest -UseBasicParsing -Uri $DatabaseServerDumpsWebPageUrl -Method Get;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$webServerDumpsGetResponse = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $DatabaseServerDumpsWebPageUrl -Method Get;
		}
		
		if (!$?){
			throw "There was an issue while getting directory $($DumpFileDirectory) Dumps list from DataBase server $($DatabaseServer) ...";
		}
		
		$warningMsg = GetHttpError $webServerDumpsGetResponse;
		
		#Retrieve Directory Dumps files names
		[String[]] $arrayOfDumpFileName = @();
		$dumpsInfoString = "'\?mode=dump_info&dir=$([System.Uri]::EscapeDataString($DumpFileDirectory))&dump=[^']+'";
		$dumpsInfoStringMatches = Select-String -InputObject $webServerDumpsGetResponse.Content -Pattern $dumpsInfoString -AllMatches;
		if ($dumpsInfoStringMatches.Matches.Count -eq 0){
			$warningMsg = "$($warningMsg) No dump file name retrieved webpage : $($DatabaseServerDumpsWebPageUrl)";
		}
		else {
			(1..$dumpsInfoStringMatches.Matches.Count).ForEach({$arrayOfDumpFileName += $dumpsInfoStringMatches.Matches[$_-1].Value.Split("=")[3].TrimEnd("'")});
		}

		#Return DumpFileNames list as String
		$returnResultString = $arrayOfDumpFileName -join "`n";
		
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	return $returnResultString;
}



<#
.SYNOPSIS
Cree une sauvegarde (backup) de la Base de donnees.
Les valeurs par defaut des parametres facultatifs suivants sont celles renseignees au debut du fichier .psm1 du module : DatabaseServer, DumpFileDirectory, WinSessionPassword, SuccessReturnCode.

.PARAMETER File
Fichier .JSON contenant les cles DatabaseName (requise), DumpToFileName (requise), DumpToFileTempName (facultative), DatabaseServer (facultative), DumpFileDirectory (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER DatabaseName
Nom de la Base de donnees a sauvegarder (requis).

.PARAMETER DumpToFileName
Nom du fichier de sauvegarde - backup - (requis).

.PARAMETER DumpToFileTempName
Nom temporaire du fichier de sauvegarde - backup - (facultatif, si fourni le nom final sera celui renseignee pour le parametre DumpToFileName).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER DumpFileDirectory
Specifie le dossier de depot du dump (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> DumpDatabase -DatabaseName "qa_auto03" -DumpToFileName "Dump_qa_auto03_20200420_1"
#>
function DumpDatabase
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpToFileName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][System.String]$DumpToFileTempName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpFileDirectory = $Script:DumpFileDirectory,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$DumpFileDirectory = "/" + "$DumpFileDirectory".Trim("/");
		
		#In case DumpToFileTempName provided
		$IsTempNameProvided = $false;
		$DumpToFileFinalName = "";
		if ($DumpToFileTempName -ne $null -and "$DumpToFileTempName".Trim() -ne "" -and "$DumpToFileTempName".Trim() -ne "$DumpToFileName".Trim()){
			$IsTempNameProvided = $true;
			$DumpToFileFinalName = $DumpToFileName;
			$DumpToFileName = $DumpToFileTempName;
		}
		
		#For result success check
		$dbDumpingSuccessString = "Dumping database $($DatabaseName) to $($DumpFileDirectory)/$($DumpToFileName)*DUMP is complete (database $($DatabaseName))";
		$dbDumpingFileNameAlreadyExistsString = "A dump with name $($DumpFileDirectory)/$($DumpToFileName)_1.dmp.cmp already exists";
		
		#For DataBase Dumping WebRequest
		$dbDumpingCompressed = "on";
		$dbDumpingNbOfStripes = "1";
		$DatabaseServerWebPageUrl = "https://$($DatabaseServer).croesus.local/sybadm/";
		$dbDumpingRequestBody = @{ compressed = $dbDumpingCompressed ; db = $DatabaseName ; dir = $DumpFileDirectory ; filename = $DumpToFileName ; mode = "dump_process" ; nb_stripes = $dbDumpingNbOfStripes };
		
		#Execute DataBase Dump
		Write-Host "Dumping $($DatabaseName)@$($DatabaseServer) to file $($DumpFileDirectory)/$($DumpToFileName) ...";
		$dbDumpingResult = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$dbDumpingResult = Invoke-WebRequest -UseBasicParsing -Uri $DatabaseServerWebPageUrl -Method Post -Body $dbDumpingRequestBody;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$dbDumpingResult = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $DatabaseServerWebPageUrl -Method Post -Body $dbDumpingRequestBody;
		}
		
		if (!$?){
			throw "There was an issue while dumping DataBase $($DatabaseName)@$($DatabaseServer) to file $($DumpFileDirectory)/$($DumpToFileName).";
		}
		
		$warningMsg = GetHttpError $dbDumpingResult;
		
		#Check DataBase Dumping Result content
		if ($dbDumpingResult.Content -like "*$dbDumpingSuccessString*"){
			$returnResultString = "$($SuccessReturnCode)";
			if ($warningMsg -ne ""){
				$returnResultString = "$($SuccessReturnCode). $($warningMsg)";
			}
		}
		else {
			$DumpToFileNameAlreadyExistsMatches = Select-String -InputObject $dbDumpingResult.Content -Pattern $dbDumpingFileNameAlreadyExistsString;
			if ($DumpToFileNameAlreadyExistsMatches.Matches.Count -ne 0){
				$returnResultString = "DUMP FILE NAME ALREADY USED. $($DumpToFileNameAlreadyExistsMatches.Matches[0].Value). $($warningMsg)".Trim();
			}
			else {
				$returnResultString = "$($warningMsg) Validation string ($($dbDumpingSuccessString)) NOT FOUND in the output content : `n`n$($dbDumpingResult.Content)".Trim();
			}
		}
		
		#Rename Dump to final name if DumpToFileTempName provided
		if ($IsTempNameProvided -eq $true -and "$($returnResultString)".StartsWith("$($SuccessReturnCode)")){
			Write-Host "Dumping database $($DatabaseName) to $($DumpFileDirectory)/$($DumpToFileName) was successful. Rename to $($DumpToFileFinalName) ..."
			$SuccessCodeRenameDump = "RenameDump : SUCCESS.";
			$ResultRenameDump = RenameDump -DumpName $DumpToFileName -DumpNewName $DumpToFileFinalName -DatabaseServer $DatabaseServer -DumpFileDirectory $DumpFileDirectory -WinSessionPassword $WinSessionPassword -SuccessReturnCode $SuccessCodeRenameDump;
			Write-Host "$($ResultRenameDump)";
			if (-not "$ResultRenameDump".StartsWith("$SuccessCodeRenameDump")){
				if ("$ResultRenameDump".StartsWith("DUMP FILE NAME ALREADY USED")){
					try {
						Write-Host "Delete temp dump file ($($DumpToFileName))";
						$executeDeleteDumpURL = "https://$($DatabaseServer).croesus.local/sybadm/?mode=delete_process&dir=$($DumpFileDirectory)&dump=$($DumpToFileName)";
						$webServerDeleteDumpGetResponse = $null;
						if ("$WinSessionPassword".Trim() -eq "") {
							$webServerDeleteDumpGetResponse = Invoke-WebRequest -UseBasicParsing -Uri $executeDeleteDumpURL -Method Get;
						}
						else {
							$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
							$webServerDeleteDumpGetResponse = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $executeDeleteDumpURL -Method Get;
						}
					}
					catch {
						Write-Host "Issue while deleting a temp dump file ($($DumpToFileName))";
					}
					return "DUMP FILE NAME ALREADY USED ($DumpToFileFinalName)."
				}
				return "RENAMING DUMP FAILED ($DumpToFileName -> $DumpToFileFinalName)."
			}
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



<#
.SYNOPSIS
Renomme une sauvegarde (backup) existante de la Base de donnees.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles DumpName (requise), DumpNewName (requise), DatabaseServer (facultative), DumpFileDirectory (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER DumpName
Nom du fichier de sauvegarde - backup - (requis).

.PARAMETER DumpNewName
Nouveau nom du fichier de sauvegarde - backup - (requis).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER DumpFileDirectory
Specifie le dossier de depot du dump (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> RenameDump -DumpName "Dump_qa_auto03_20200420_1" -DumpNewName "Dump_renommee_qa_auto03_20200420_1"
#>
function RenameDump
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpNewName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpFileDirectory = $Script:DumpFileDirectory,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		#Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		#Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$DumpFileDirectory = "/" + "$DumpFileDirectory".Trim("/");
		
		#For result success check
		$renameDumpSuccessString = "Renaming dump '$($DumpName)' to '$($DumpNewName)'*$($DumpFileDirectory)/$($DumpName)_1.dmp.cmp -> $($DumpFileDirectory)/$($DumpNewName)_1.dmp.cmp";
		$DumpNameAlreadyExistsString = "Renaming dump '$($DumpName)' to '$($DumpNewName)'*Dump '$($DumpNewName)' already exists";
		$DumpNameFileNotFoundString = "Renaming dump '$($DumpName)' to '$($DumpNewName)'*No files found for dump '$($DumpName)'";
		$IllegalCharacterFoundString = "Renaming dump '$($DumpName)' to '$($DumpNewName)'*Illegal character '*' in dump filename";

		
		#For DataBase Load WebRequest
		$DatabaseServerWebPageUrl = "https://$($DatabaseServer).croesus.local/sybadm/?mode=rename_dump_form";
		$renameDumpRequestBody = @{ dir = $DumpFileDirectory ; dump = $DumpName ; mode = "rename_dump_process" ; newdump = $DumpNewName };
		
		#Execute DataBase Load
		Write-Host "Renaming dump $($DumpName) to $($DumpNewName) in ($($DumpFileDirectory))...";
		$webServerResponse = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$webServerResponse = Invoke-WebRequest -UseBasicParsing -Uri $DatabaseServerWebPageUrl -Method Post -Body $renameDumpRequestBody;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$webServerResponse = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $DatabaseServerWebPageUrl -Method Post -Body $renameDumpRequestBody;
		}
		
		if (!$?){
			throw "There was an issue while renaming dump $($DumpName) to $($DumpNewName) in ($($DumpFileDirectory)).";
		}
		
		$warningMsg = GetHttpError $webServerResponse;
		
		#Check DataBase Loading Result content
		if ($webServerResponse.Content -like "*$renameDumpSuccessString*"){
			$returnResultString = "$($SuccessReturnCode)";
			if ($warningMsg -ne ""){
				$returnResultString = "$($SuccessReturnCode). $($warningMsg)";
			}
		}
		elseif ($webServerResponse.Content -like "*$DumpNameAlreadyExistsString*"){
			$returnResultString = "DUMP FILE NAME ALREADY USED. $($DumpNameAlreadyExistsString). $($warningMsg)".Trim();
		}
		elseif ($webServerResponse.Content -like "*$DumpNameFileNotFoundString*"){
			$returnResultString = "FILE NOT FOUND. $($DumpNameFileNotFoundString). $($warningMsg)".Trim();
		}
		elseif ($webServerResponse.Content -like "*$IllegalCharacterFoundString*"){
			$returnResultString = "ILLEGAL CHARACTER IN DUMP NAME. $($IllegalCharacterFoundString). $($warningMsg)".Trim();
		}
		else {
			$returnResultString = "$($warningMsg) Validation string ($($renameDumpSuccessString)) NOT FOUND in the output content : `n`n$($webServerResponse.Content)".Trim();
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



<#
.SYNOPSIS
Charge une Base de donnees a partir d'une sauvegarde (backup) existante.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles DatabaseName (requise), LoadFromDumpName (requise), DatabaseServer (facultative), DumpFileDirectory (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER DatabaseName
Nom de la Base de donnees (requis).

.PARAMETER LoadFromDumpName
Nom du fichier de sauvegarde - backup - existante (requis).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER DumpFileDirectory
Specifie le dossier de depot du dump (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> LoadDatabase -DatabaseName "qa_auto03" -LoadFromDumpName "Dump_qa_auto03_20200420_1"
#>
function LoadDatabase
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$LoadFromDumpName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DumpFileDirectory = $Script:DumpFileDirectory,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$DumpFileDirectory = "/" + "$DumpFileDirectory".Trim("/");
		
		#For result success check
		$dbLoadingSuccessString = "Loading database $($DatabaseName) from $($LoadFromDumpName)*LOAD is complete (database $($DatabaseName))";
		$successReturnStatusString = "\(return status = 0\)";
		$allReturnStatusStrings = "\(return status = .*\)";
		$LoadFromDumpNameNotFoundString = "No dump with name $($LoadFromDumpName) exists";
		
		#For DataBase Load WebRequest
		$dbLoadingKillAll = "on";
		$DatabaseServerWebPageUrl = "https://$($DatabaseServer).croesus.local/sybadm/";
		$dbLoadingRequestBody = @{ db = $DatabaseName ; dir = $DumpFileDirectory ; dump = $LoadFromDumpName ; killall = $dbLoadingKillAll ; mode = "load_process" };
		
		#Execute DataBase Load
		Write-Host "Loading dump $($DumpFileDirectory)/$($LoadFromDumpName) to $($DatabaseName)@$($DatabaseServer) ...";
		$dbLoadingResult = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$dbLoadingResult = Invoke-WebRequest -UseBasicParsing -Uri $DatabaseServerWebPageUrl -Method Post -Body $dbLoadingRequestBody;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$dbLoadingResult = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $DatabaseServerWebPageUrl -Method Post -Body $dbLoadingRequestBody;
		}
		
		if (!$?){
			throw "There was an issue while loading dump $($LoadFromDumpName) to $($DatabaseName)@$($DatabaseServer).";
		}
		
		$warningMsg = GetHttpError $dbLoadingResult;
		
		#Check DataBase Loading Result content
		if ($dbLoadingResult.Content -like "*$dbLoadingSuccessString*"){		
			$successReturnStatusMatches = Select-String -InputObject $dbLoadingResult.Content -Pattern $successReturnStatusString -AllMatches;
			$allReturnStatusMatches = Select-String -InputObject $dbLoadingResult.Content -Pattern $allReturnStatusStrings -AllMatches;
			$nbOfNotMatchingSuccessReturnStatus = $allReturnStatusMatches.Matches.Count - $successReturnStatusMatches.Matches.Count;
			if ($nbOfNotMatchingSuccessReturnStatus -ne 0){
				$warningMsg = "$($warningMsg) $($nbOfNotMatchingSuccessReturnStatus) return status code not matching $($successReturnStatusString).".Trim();
			}
			
			$returnResultString = "$($SuccessReturnCode)";
			if ($warningMsg -ne ""){
				$returnResultString = "$($SuccessReturnCode). $($warningMsg)";
			}
		}
		else {
			if ($dbLoadingResult.Content -like "*$LoadFromDumpNameNotFoundString*"){
				$returnResultString = "DUMP FILE NOT FOUND. $($LoadFromDumpNameNotFoundString). $($warningMsg)".Trim();
			}
			else {
				$returnResultString = "$($warningMsg) Validation string ($($dbLoadingSuccessString)) NOT FOUND in the output content : `n`n$($dbLoadingResult.Content)".Trim();
			}
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



<#
.SYNOPSIS
Realise toutes les operations de migration du VServer.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), ReferenceName (requise), DatabaseName (requise), DatabaseServer (facultative), Master (facultative), Platform (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
URL du VServer (requis).

.PARAMETER ReferenceName
Nom de la Reference comme il apparait dans la fenetre d'edition qui s'affiche lorsqu'on clique sur Edit d'un vserver. (requis).

.PARAMETER DatabaseName
Nom de la Base de donnees (requis).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER Master
Specifie le Nom du Master (facultatif).

.PARAMETER Platform
Specifie le nom de la platforme (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> MigrateVserver -VServerURL "http://auto-VSERVER03.croesus.local" -ReferenceName "ref90-15-2020-3-64--V9-croesus-co7x-1_8_2_653" -DatabaseName "qa_auto03"
#>
function MigrateVserver
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$ReferenceName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Master = $Script:Master,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Platform = $Script:Platform,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	
	#Parameters
	Write-Host "********************************************************";
	#Write-Host $MyInvocation.MyCommand.Name;
	$myParameters = @{};
	if ($File -eq $null){
		$myParameters = $PSBoundParameters.PSObject.BaseObject;
	}
	else {
		Write-Host "Parameters from File : " $File;
		$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
		foreach ($property in $myFileParamsJson.PSObject.Properties) {
			if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
				Set-Variable -Name $property.Name -Value $property.Value;
				$myParameters[$property.Name] = $property.Value;
			}
		}
	}
	#Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
	#Parameters
    
	#0. Restart VServer
	#$SuccessCodeRestartVserver = "Prior Restart VServer : SUCCESS.";
	#$ResultRestartVserver = RestartVserver -VServerURL $VServerURL -SuccessReturnCode $SuccessCodeRestartVserver;
	#Write-Host "$($ResultRestartVserver)";
	#if (-not "$ResultRestartVserver".StartsWith("$SuccessCodeRestartVserver")){return "MIGRATION NOT COMPLETED, failed upon Prior Restart VServer process."}
	
	Write-Host;
	#1. Execute Migration
	$SuccessCodeMigration = "Mig -> Migration : SUCCESS.";
	$ResultExecMigration = ExecuteVserverMigMigration -VServerURL $VServerURL -DatabaseName $DatabaseName -ReferenceName $ReferenceName -SuccessReturnCode $SuccessCodeMigration;
	Write-Host "$($ResultExecMigration)";
	if (-not "$ResultExecMigration".StartsWith("$SuccessCodeMigration")){return "MIGRATION NOT COMPLETED, failed upon Exec Migration process."}
	
	#2. Stop VServer
	$SuccessCodeStopVserver = "Stop VServer : SUCCESS.";
	$ResultStopVserver = StopVserver -VServerURL $VServerURL -SuccessReturnCode $SuccessCodeStopVserver;
	Write-Host "$($ResultStopVserver)";
	if (-not "$ResultStopVserver".StartsWith("$SuccessCodeStopVserver")){return "MIGRATION NOT COMPLETED, failed upon VServer Stop process."}
	
	#3. Start VServer
	$SuccessCodeStartVserver = "Start VServer : SUCCESS.";
	$ResultStartVserver = StartVserver -VServerURL $VServerURL -SuccessReturnCode $SuccessCodeStartVserver;
	Write-Host "$($ResultStartVserver)";
	if (-not "$ResultStartVserver".StartsWith("$SuccessCodeStartVserver")){return "MIGRATION NOT COMPLETED, failed upon VServer Start process."}
	
	#4. Execute RTM
	$SuccessCodeRTM = "Mig -> RTM : SUCCESS.";
	$ResultExecRTM = ExecuteVserverMigRTM -VServerURL $VServerURL -DatabaseName $DatabaseName -ReferenceName $ReferenceName -SuccessReturnCode $SuccessCodeRTM;
	Write-Host "$($ResultExecRTM)";
	if (-not "$ResultExecRTM".StartsWith("$SuccessCodeRTM")){return "MIGRATION NOT COMPLETED, failed upon Exec RTM process."}
	
	#Return $SuccessReturnCode if all steps succeeded
	Write-Host "`nMIGRATION COMPLETED.";
    Write-Host "********************************************************";
	return $SuccessReturnCode;
}



<#
.SYNOPSIS
Realise l'operation Mig -> Migration du VServer.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), ReferenceName (requise), DatabaseName (requise), DatabaseServer (facultative), Master (facultative), Platform (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
URL du VServer (requis).

.PARAMETER ReferenceName
Nom de la Reference comme il apparait dans la fenetre d'edition qui s'affiche lorsqu'on clique sur Edit d'un vserver. (requis).

.PARAMETER DatabaseName
Nom de la Base de donnees (requis).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER Master
Specifie le Nom du Master (facultatif).

.PARAMETER Platform
Specifie le nom de la platforme (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> ExecuteVserverMigMigration -VServerURL "http://auto-VSERVER03.croesus.local" -ReferenceName "ref90-15-2020-3-64--V9-croesus-co7x-1_8_2_653" -DatabaseName "qa_auto03"
#>
function ExecuteVserverMigMigration
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$ReferenceName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Master = $Script:Master,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Platform = $Script:Platform,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		
		if ($File -ne $null){
			$myParameters = @{};
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
			Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		}
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		$Reference = ($ReferenceName -split "ref")[1];
		
		#For result success check
		$migrationSuccessString = "Migration $($VServerName) -&gt; $($ReferenceName)*The script ended normally";
		
		#For Migration WebRequest
		$executeMigrationURL = "https://$($Platform).croesus.local/cgi-bin/migration.cgi?vserver=$($VServerName)&master=$($Master)&dbs=$($DatabaseServer)&db=$($DatabaseName)&ref=$($ReferenceName)&mode=exec&exec_mig=Start+Migration+->+$($Reference)";
		
		#Execute Migration WebRequest
		Write-Host "Executing VServer $($VServerName) Migration to version $($ReferenceName) ...";
		$executeMigrationResult = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$executeMigrationResult = Invoke-WebRequest -UseBasicParsing -Uri $executeMigrationURL -Method Get;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$executeMigrationResult = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $executeMigrationURL -Method Get;
		}
		
		if (!$?){
			throw "There was an issue while executing VServer $($VServerName) Migration to version $($ReferenceName).";
		}
		
		$warningMsg = GetHttpError $executeMigrationResult;
		
		#Check Migration Result content
		if ($executeMigrationResult.Content -like "*$migrationSuccessString*"){
			$returnResultString = "$($SuccessReturnCode)";
			if ($warningMsg -ne ""){
				$returnResultString = "$($SuccessReturnCode). $($warningMsg)";
			}
		}
		else {
			$returnResultString = "$($warningMsg) Validation string ($($migrationSuccessString)) NOT FOUND in the output content : `n`n$($executeMigrationResult.Content)".Trim();
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}

	
	return $returnResultString;
}



<#
.SYNOPSIS
Realise l'operation Mig -> RTM du VServer.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), ReferenceName (requise), DatabaseName (requise), DatabaseServer (facultative), Master (facultative), Platform (facultative), WinSessionPassword (facultative), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
URL du VServer (requis).

.PARAMETER ReferenceName
Nom de la Reference comme il apparait dans la fenêtre d'édition qui s'affiche lorsqu'on clique sur Edit d'un vserver. (requis).

.PARAMETER DatabaseName
Nom de la Base de donnees (requis).

.PARAMETER DatabaseServer
Specifie le Serveur de base de donnees (facultatif).

.PARAMETER Master
Specifie le Nom du Master (facultatif).

.PARAMETER Platform
Specifie le nom de la platforme (facultatif).

.PARAMETER WinSessionPassword
Specifie le mot de passe de l'utilisateur Windows (facultatif).

.PARAMETER SuccessReturnCode
Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> ExecuteVserverMigRTM -VServerURL "http://auto-VSERVER03.croesus.local" -ReferenceName "ref90-15-2020-3-64--V9-croesus-co7x-1_8_2_653" -DatabaseName "qa_auto03"
#>
function ExecuteVserverMigRTM
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$ReferenceName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$DatabaseServer = $Script:DatabaseServer,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Master = $Script:Master,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$Platform = $Script:Platform,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$WinSessionPassword = $Script:WinSessionPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		
		if ($File -ne $null){
			$myParameters = @{};
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
			Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		}
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		$Reference = ($ReferenceName -split "ref")[1];
		
		#For result success check
		$migrationSuccessString = "Migration $($VServerName) -&gt; $($ReferenceName)*Report Template Manager Ended";
		$successReturnStatusString = "Report validation successful \[Name:.*\]";
		$allReturnStatusStrings = "Report validation .*\[Name:.*\]";
		
		#For Migration RTM WebRequest
		$executeMigrationURL = "https://$($Platform).croesus.local/cgi-bin/migration.cgi?vserver=$($VServerName)&master=$($Master)&dbs=$($DatabaseServer)&db=$($DatabaseName)&ref=$($ReferenceName)&mode=exec&exec_rtm=Start+RTM+->+$($Reference)";
		
		#Execute Migration RTM WebRequest
		Write-Host "Executing VServer $($VServerName) RTM to version $($ReferenceName) ...";
		$executeMigrationResult = $null;
		if ("$WinSessionPassword".Trim() -eq "") {
			$executeMigrationResult = Invoke-WebRequest -UseBasicParsing -Uri $executeMigrationURL -Method Get;
		}
		else {
			$userCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $env:username, $(ConvertTo-SecureString -String "$WinSessionPassword" -AsPlainText -Force);
			$executeMigrationResult = Invoke-WebRequest -UseBasicParsing -Credential $userCredential -Uri $executeMigrationURL -Method Get;
		}
		
		if (!$?){
			throw "There was an issue while executing VServer $($VServerName) RTM to version $($ReferenceName).";
		}
		
		$warningMsg = GetHttpError $executeMigrationResult;
		
		#Check Migration RTM Result content
		if ($executeMigrationResult.Content -like "*$migrationSuccessString*"){
			$successReturnStatusMatches = Select-String -InputObject $executeMigrationResult.Content -Pattern $successReturnStatusString -AllMatches;
			$allReturnStatusMatches = Select-String -InputObject $executeMigrationResult.Content -Pattern $allReturnStatusStrings -AllMatches;
			$nbOfNotMatchingSuccessReturnStatus = $allReturnStatusMatches.Matches.Count - $successReturnStatusMatches.Matches.Count;
			if ($nbOfNotMatchingSuccessReturnStatus -ne 0){
				$warningMsg = "$($warningMsg) $($nbOfNotMatchingSuccessReturnStatus) return status code not matching $($successReturnStatusString).".Trim();
			}
			
			$returnResultString = "$($SuccessReturnCode)";
			if ($warningMsg -ne ""){
				$returnResultString = "$($SuccessReturnCode). $($warningMsg)";
			}
		}
		else {
			$returnResultString = "$($warningMsg) Validation string ($($migrationSuccessString)) NOT FOUND in the output content : `n`n$($executeMigrationResult.Content)".Trim();
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



<#
.SYNOPSIS
Arrete le VServer specifie.
La valeur par defaut du parametre facultatif SuccessReturnCode est celle renseignee au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
Specifie le VServer a arreter.

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> StopVserver -VServerURL "http://auto-VSERVER04.croesus.local" -SuccessReturnCode "VSERVER STOPPED"
#>
function StopVserver
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		
		#Stop the vserver
		Write-Host "Stopping the VServer $($VServerURL) ...";
		ImportModuleReleaseFoundations;
		Stop-VServer $VServerName | Out-Null;
		
		#Verify if the VServer is actually stopped
		Write-Host "`nVerify if the VServer is actually stopped ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		Start-Sleep -s 5;
		Update-VServer $objVserver | Out-Null;
		
		#Result
		$returnResultString = "";
		if ($objVserver.IsRunning){
			$warningMsg = "The VServer is still running after command Stop-VServer $($VServerName) execution.";
			$returnResultString = $warningMsg;
		}
		else {
			Write-Host "The VServer is actually stopped.";
			$returnResultString = "$($SuccessReturnCode)";
		}

	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	
	return $returnResultString;
}



<#
.SYNOPSIS
Demarre le VServer specifie.
La valeur par defaut du parametre facultatif SuccessReturnCode est celle renseignee au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
Specifie le VServer a demarrer.

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> StartVserver -VServerURL "http://auto-VSERVER04.croesus.local" -SuccessReturnCode "VSERVER STARTED"
#>
function StartVserver
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		
		#Start the vserver
		Write-Host "Starting the VServer $($VServerURL) ...";
		ImportModuleReleaseFoundations;
		Start-VServer $VServerName | Out-Null;
		
		#Verify if the VServer is actually running
		Write-Host "`nVerify if the VServer is actually running ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		Start-Sleep -s 5;
		Update-VServer $objVserver | Out-Null;
		
		#Result
		if ($objVserver.IsRunning){
			Write-Host "The VServer is actually running.";
			$returnResultString = "$($SuccessReturnCode)";
		}
		else {
			$warningMsg = "The VServer is not running after command Start-VServer $($VServerName) execution.";
			$returnResultString = $warningMsg;
		}

	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	return $returnResultString;
}



<#
.SYNOPSIS
Redemarre le VServer specifie.
La valeur par defaut du parametre facultatif SuccessReturnCode est celle renseignee au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles VServerURL (requise), SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
Specifie le VServer a redemarrer.

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> StartVserver -VServerURL "http://auto-VSERVER04.croesus.local" -SuccessReturnCode "VSERVER RESTARTED"
#>
function RestartVserver
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		
		#Restart the vserver
		Write-Host "Restarting the VServer $($VServerURL) ...";
		ImportModuleReleaseFoundations;
		Restart-VServer $VServerName | Out-Null;
		
		#Verify if the VServer is actually running
		Write-Host "`nVerify if the VServer is actually running ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		Start-Sleep -s 5;
		Update-VServer $objVserver | Out-Null;
		
		#Result
		if ($objVserver.IsRunning){
			Write-Host "The VServer is actually running.";
			$returnResultString = "$($SuccessReturnCode)";
		}
		else {
			$warningMsg = "The VServer is not running after command Restart-VServer $($VServerName) execution.";
			$returnResultString = $warningMsg;
		}

	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}

	
	return $returnResultString;
}



<#
.SYNOPSIS
Edite le VServer specifie (Change sa Reference et/ou son AssembleScript).
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles : VServerURL, ReferenceName, VServerPassword, AssembleScriptPath, EditOutputPath, SuccessReturnCode.
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
Specifie le VServer a editer.

.PARAMETER ReferenceName
Specifie la nouvelle reference.

.PARAMETER VServerPassword
Specifie le mot de passe root a inscrire dans l'Assemble Script du VServer (faculatif).

.PARAMETER AssembleScriptPath
Specifie le chemin d'acces du fichier contenant l'Assemble.Script.

.PARAMETER EditOutputPath
Specifie le le chemin d'acces du fichier .JSON ou les proprietes suivantes du VServer vont etre inscrites a l'issue de la mise a jour : VServerName, ReferenceName, Master, Platform

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.
Inscrit dans le fichier specifie par EditOutputPath : VServerName, ReferenceName, Master, Platform
Si EditOutputPath n'est pas renseigne, alors sa valeur par defaut sera un fichier dans le dossier temporaire

.EXAMPLE 
PS> UpdateVserverAssembleScript -VServerURL "http://auto-VSERVER04.croesus.local" -ReferenceName "ref90-15-2020-3-64--V9-croesus-co7x-1_8_2_653" -AssembleScriptPath "C:\s-backup\QA Tests\TestCompleteProjects20203\Data\AssembleScript_BNC_FM-13.txt" -SuccessReturnCode "VSERVER EDITED"
#>
function EditVserver
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][System.String]$ReferenceName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerPassword = $Script:VServerPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][System.String]$AssembleScriptPath = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$EditOutputPath = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		
		$VServerName = GetVserverName -VServerURL $VServerURL;
		ImportModuleReleaseFoundations;
		
		#Check if referenceName exists
		if ("$ReferenceName".Trim() -ne ""){
			$objReferences = $null;
			$objReferences = Get-Reference

			if ($objReferences -eq $null){
				throw "There was an issue while getting References object.";
			}
			
			$isReferenceNameFound = $false;
			foreach ($objReference in $objReferences){
				if ($objReference.Name -eq $ReferenceName){
					$isReferenceNameFound = $true;
					break;
				}
			}
			
			if (!$isReferenceNameFound){
				throw "The Reference Name $($ReferenceName) was not found in the Reference Names list.";
			}
		}
		
		#Update the vserver reference and/or assemble script if necessary
		Write-Host "`nUpdate the VServer $($VServerURL) reference and/or assemble script if necessary ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		$whatToUpdate = "";
		
		if ("$ReferenceName".Trim() -eq ""){
			Write-Host "The ReferenceName parameter value is empty, no update for the VServer Reference Name.";
		}
		elseif ($objVserver.Reference.Name -ne $ReferenceName){
			$whatToUpdate += "UpdateReferencename";
			Write-Host "The VServer Reference Name will be updated to $($ReferenceName) ...";
		}
		else {
			$warningMsg = "$($warningMsg)The Reference Name matches. ";
			Write-Host "$($warningMsg)No need to update it.";
		}
		
		if ("$AssembleScriptPath".Trim() -eq ""){
			Write-Host "The AssembleScriptPath parameter value is empty, no update for the VServer Assemble Script.";
		}
		elseif (-not(Test-Path $AssembleScriptPath)){
			$warningMsg = "$($warningMsg)Assemble Script file path not found : $($AssembleScriptPath). ";
		}
		else {
			$AssembleScript = "$(Get-Content -Raw -Path $($AssembleScriptPath))" -replace "FOR_TESTS_AUTO_VSERVER_URL_TO_BE_SPECIFIED", $VServerURL -replace "FOR_TESTS_AUTO_VSERVER_ROOT_PSWD_TO_BE_SPECIFIED", $vServerPassword;
			if (-not ([regex]::Replace($objVserver.AssembleScript, "[`r`n]", {param($match) ""}) -ceq [regex]::Replace($AssembleScript, "[`r`n]", {param($match) ""}))){
				$whatToUpdate += "UpdateAssemblescript";
				Write-Host "The VServer Assemble Script will be updated ...";
			}
			else {
				$warningMsg = "$($warningMsg)The Assemble Script matches. ";
				Write-Host "$($warningMsg)No need to update it.";
			}
		}
		
		switch ($whatToUpdate){
			""                     {$warningMsg = "$($warningMsg)Neither the VServer Reference Name nor Assemble Script has been updated."; break;}
			"UpdateReferencename"  {Edit-VServer -VServerName $VServerName -Reference $ReferenceName | Out-Null; break;}
			"UpdateAssemblescript" {Edit-VServer -VServerName $VServerName -AssembleScript "$assembleScript" | Out-Null; break;}
			Default                {Edit-VServer -VServerName $VServerName -Reference $ReferenceName -AssembleScript "$assembleScript" | Out-Null; break;}
		}
		
		if (!$?){
			throw "There was an issue while updating the VServer $($VServerName)";
		}
		
		#Validate the update of vserver reference and/or assemble script 
		if ($whatToUpdate -eq ""){
			$returnResultString = "$($SuccessReturnCode)";
		}
		elseif ("$ReferenceName".Trim() -ne "" -or "$AssembleScriptPath".Trim() -ne ""){
			Write-Host "`nValidate the VServer $($VServerURL) update ...";
			Start-Sleep -s 5;
			$objVserver = $null;
			$objVserver = Get-VServer $VServerName;
			if ($objVserver -eq $null){
				throw "There was an issue while getting the VServer $($VServerName) object.";
			}
			
			if ("$ReferenceName".Trim() -ne "" -and $objVserver.Reference.Name -ne $ReferenceName){
				$warningMsg = "$($warningMsg)Upon Update, the VServer $($VServerName) Reference Name ($($objVserver.Reference.Name)) is not the expected one ($($ReferenceName)). ";
			}
			
			if ("$AssembleScriptPath".Trim() -ne "" -and -not ([regex]::Replace($objVserver.AssembleScript, "[`r`n]", {param($match) ""}) -ceq [regex]::Replace($assembleScript, "[`r`n]", {param($match) ""}))){
				$warningMsg = "$($warningMsg)Upon Update, the VServer $($VServerName) Assemble Script is not the expected one. `n`nActual Assemble Script :`n $($objVserver.AssembleScript) `n`n`nExpected Assemble Script :`n $($assembleScript)`n ";
			}
			
			if ($warningMsg -eq ""){
				$returnResultString = "$($SuccessReturnCode)";
				Write-Host "The VServer $($VServerURL) update was successfull.";
			}
		}
		
		$ReferenceName = $objVserver.Reference.Name;
		if ($ReferenceName -eq $null -or $ReferenceName -eq ""){
			$warningMsg = "$($warningMsg)The VServer $($VServerName) retrieved ReferenceName is empty, this is unexpected. ";
		}
		
		$Master = $objVserver.Master;
		if ($Master -eq $null -or $Master -eq ""){
			$warningMsg = "$($warningMsg)The VServer $($VServerName) retrieved Master Name is empty, this is unexpected. ";
		}
		
		$Platform = $objVserver.Platform;
		if ($Platform -eq $null -or $Platform -eq ""){
			$warningMsg = "$($warningMsg)The VServer $($VServerName) retrieved Platform Name is empty, this is unexpected. ";
		}
		
		#Write VServer properties to JSON file
		if ("$VServerPropertiesPath".Trim() -eq ""){
			$VServerPropertiesPath = "$($env:temp)\Vserver_$($VServerName)_Properties_$(Get-Date -Format "yyyMMdd_HHmmss").json";
		}
		
		if (Test-Path $VServerPropertiesPath){
			Remove-Item $VServerPropertiesPath -Force;
		}
		
		Write-Host "`nExport The VServer properties to file : $($VServerPropertiesPath) ...";
		$VServerProperties = @{ VServerName = $($VServerName);
								ReferenceName = $($ReferenceName);
								Platform = $($Platform);
								Master = $($Master);
							  }
		
		Write-Host "VServer $($VServerURL) properties are :";
		Write-Host ($VServerProperties | Out-String).Trim();
		
		$VServerProperties | ConvertTo-Json | Out-File -filePath $VServerPropertiesPath;
		Start-Sleep -s 5;
		
		if (-not(Test-Path $VServerPropertiesPath)){
			$warningMsg = "$($warningMsg)Export output file not found : $($VServerPropertiesPath). ";
		}
		else {
			$VServerPropertiesFromFileJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $VServerPropertiesPath)";
			$VServerPropertiesFromFile = @{};
			foreach ($property in $VServerPropertiesFromFileJson.PSObject.Properties) {
				$VServerPropertiesFromFile[$property.Name] = $property.Value;
			}
			
			if ((Out-String -inputObject $VServerPropertiesFromFile) -ceq (Out-String -inputObject $VServerProperties)){
				Write-Host "VServer properties were successfully exported to the output file : $($VServerPropertiesPath)";
			}
			else {
				Write-Host "Export output file $($VServerPropertiesPath) content :";
				Get-Content -Raw -Path $VServerPropertiesPath;
				$warningMsg = "$($warningMsg)There was an issue while exporting VServer properties to the output file : $($VServerPropertiesPath). ";
			}
		}
		
		if ($warningMsg -ne ""){
			if ($returnResultString -eq ""){
				$returnResultString = "$($warningMsg)";
			}
			else {
				$returnResultString = "$($returnResultString). $($warningMsg)";
			}
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	return $returnResultString;
}



<#
.SYNOPSIS
Change la Reference du VServer specifie.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles : VServerURL, ReferenceName, SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres

.PARAMETER VServerURL
Specifie le VServer a editer.

.PARAMETER ReferenceName
Specifie la nouvelle reference.

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> UpdateVserverReference -VServerURL "http://auto-VSERVER04.croesus.local" -ReferenceName "ref90-15-2020-3-64--V9-croesus-co7x-1_8_2_653" -SuccessReturnCode "REFERENCE UPDATED"
#>
function UpdateVserverReference
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][System.String]$ReferenceName = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;
		
		ImportModuleReleaseFoundations;
		
		#Check if referenceName exists
		if ("$ReferenceName".Trim() -ne ""){
			$objReferences = $null;
			$objReferences = Get-Reference

			if ($objReferences -eq $null){
				throw "There was an issue while getting References object.";
			}
			
			$isReferenceNameFound = $false;
			foreach ($objReference in $objReferences){
				if ($objReference.Name -eq $ReferenceName){
					$isReferenceNameFound = $true;
					break;
				}
			}
			
			if (!$isReferenceNameFound){
				$warningMsg = "$($warningMsg)The Reference Name $($ReferenceName) was not found in the Reference Names list.";
			}
		}
		
		#Update the vserver reference and/or assemble script if necessary
		Write-Host "`nUpdate the VServer $($VServerURL) reference if necessary ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		$whatToUpdate = "";
		
		if ("$ReferenceName".Trim() -eq ""){
			Write-Host "The ReferenceName parameter value is empty, no update for the VServer Reference Name.";
		}
		elseif ($objVserver.Reference.Name -ne $ReferenceName){
			$whatToUpdate += "UpdateReferencename";
			Write-Host "The VServer Reference Name will be updated to $($ReferenceName) ...";
		}
		else {
			$warningMsg = "$($warningMsg)The Reference Name to set matched the current one. No need to update it. ";
			return "$($SuccessReturnCode). $($warningMsg) ";
		}
		
		
		switch ($whatToUpdate){
			""                     {$warningMsg = "$($warningMsg)The VServer Reference Name has not been updated."; break;}
			"UpdateReferencename"  {Edit-VServer -VServerName $VServerName -Reference $ReferenceName | Out-Null; break;}
			Default                {Edit-VServer -VServerName $VServerName -Reference $ReferenceName | Out-Null; break;}
		}
		
		if (!$?){
			throw "There was an issue while updating the VServer $($VServerName)";
		}
		
		#Validate the update of vserver reference and/or assemble script 
		if ($whatToUpdate -eq ""){
			$returnResultString = "$($SuccessReturnCode)";
		}
		elseif ("$ReferenceName".Trim() -ne ""){
			Write-Host "`nValidate the VServer $($VServerURL) update ...";
			Start-Sleep -s 5;
			$objVserver = $null;
			$objVserver = Get-VServer $VServerName;
			if ($objVserver -eq $null){
				throw "There was an issue while getting the VServer $($VServerName) object.";
			}
			
			if ("$ReferenceName".Trim() -ne "" -and $objVserver.Reference.Name -ne $ReferenceName){
				$warningMsg = "$($warningMsg)Upon Update, the VServer $($VServerName) Reference Name ($($objVserver.Reference.Name)) is not the expected one ($($ReferenceName)). ";
			}
			
			if ($warningMsg -eq ""){
				$returnResultString = "$($SuccessReturnCode)";
				Write-Host "The VServer $($VServerURL) update was successfull.";
			}
		}
		
		if ($warningMsg -ne ""){
			if ($returnResultString -eq ""){
				$returnResultString = "$($warningMsg)";
			}
			else {
				$returnResultString = "$($returnResultString). $($warningMsg)";
			}
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	return $returnResultString;
}



<#
.SYNOPSIS
Modifie l'Assemble Script du VServer specifie.
Les valeurs par defaut des parametres facultatifs sont celles renseignees au debut du fichier .psm1 du module.

.PARAMETER File
Fichier .JSON contenant les cles : VServerURL, VServerPassword (facultative), AssembleScriptPath, SuccessReturnCode (facultative).
Ne pas renseigner si les arguments sont fournis en parametres.

.PARAMETER VServerURL
Specifie le VServer a editer.

.PARAMETER VServerPassword
Specifie le mot de passe root a inscrire dans l'Assemble Script du VServer (faculatif).

.PARAMETER AssembleScriptPath
Specifie le chemin d'acces du fichier contenant le nouvel Assemble Script.

.PARAMETER SuccessReturnCode
Specifie le Code - chaine de caracteres - de retour en cas de succes (facultatif).

.OUTPUTS
String : valeur du parametre SuccessReturnCode en cas de succes. En cas d'echec, une autre chaine de caracteres renseignant sur la nature de l'echec.

.EXAMPLE 
PS> UpdateVserverAssembleScript -VServerURL "http://auto-VSERVER04.croesus.local" -AssembleScriptPath "C:\s-backup\QA Tests\TestCompleteProjects20203\Data\AssembleScript_BNC_FM-13.txt" -SuccessReturnCode "ASSEMBLE SCRIPT UPDATED"
#>
function UpdateVserverAssembleScript
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerPassword = $Script:VServerPassword,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][System.String]$AssembleScriptPath = "",
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$SuccessReturnCode = $Script:SuccessReturnCode
	)
	
	try {
		#Parameters
		Write-Host "========================================================";
		Write-Host $MyInvocation.MyCommand.Name;
		$myParameters = @{};
		if ($File -eq $null){
			$myParameters = $PSBoundParameters.PSObject.BaseObject;
		}
		else {
			Write-Host "Parameters from File : " $File;
			$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
			foreach ($property in $myFileParamsJson.PSObject.Properties) {
				if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
					Set-Variable -Name $property.Name -Value $property.Value;
					$myParameters[$property.Name] = $property.Value;
				}
			}
		}
		Write-Host ($myParameters | Format-Table @{Label="Parameters"; Expression={$_.Key }}, @{Label="Values"; Expression={$_.Value}} | Out-String).Trim();
		#Parameters
		
		$returnResultString = "";
		$warningMsg = "";
		$VServerName = GetVserverName -VServerURL $VServerURL;

		
		#Update the vserver ssemble script if necessary
		ImportModuleReleaseFoundations;
		Write-Host "`nUpdate the VServer $($VServerURL) assemble script if necessary ...";
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		$whatToUpdate = "";
		
		if ("$AssembleScriptPath".Trim() -eq ""){
			$warningMsg = "$($warningMsg)The AssembleScriptPath parameter value is empty, no update for the VServer Assemble Script.";
		}
		elseif (-not(Test-Path $AssembleScriptPath)){
			$warningMsg = "ABORTED : Assemble Script file not found ($($AssembleScriptPath)). "
			return "$($warningMsg)";
		}
		else {
			$AssembleScript = "$(Get-Content -Raw -Path $($AssembleScriptPath))" -replace "FOR_TESTS_AUTO_VSERVER_URL_TO_BE_SPECIFIED", $VServerURL -replace "FOR_TESTS_AUTO_VSERVER_ROOT_PSWD_TO_BE_SPECIFIED", $vServerPassword;
			if (-not ([regex]::Replace($objVserver.AssembleScript, "[`r`n]", {param($match) ""}) -ceq [regex]::Replace($AssembleScript, "[`r`n]", {param($match) ""}))){
				$whatToUpdate += "UpdateAssemblescript";
				Write-Host "The VServer Assemble Script will be updated ...";
			}
			else {
				$warningMsg = "$($warningMsg)The Assemble Script to set matched the current one. No need to update it. ";
				return "$($SuccessReturnCode). $($warningMsg) ";
			}
		}
		
		switch ($whatToUpdate){
			""                     {$warningMsg = "$($warningMsg)Assemble Script has not been updated. "; break;}
			"UpdateAssemblescript" {Edit-VServer -VServerName $VServerName -AssembleScript "$assembleScript" | Out-Null; break;}
			Default                {Edit-VServer -VServerName $VServerName -AssembleScript "$assembleScript" | Out-Null; break;}
		}
		
		if (!$?){
			throw "There was an issue while updating the VServer $($VServerName)";
		}
		
		#Validate the update of vserver reference and/or assemble script 
		if ($whatToUpdate -eq ""){
			$returnResultString = "$($SuccessReturnCode)";
		}
		elseif ("$AssembleScriptPath".Trim() -ne ""){
			Write-Host "`nValidate the VServer $($VServerURL) update ...";
			Start-Sleep -s 5;
			$objVserver = $null;
			$objVserver = Get-VServer $VServerName;
			if ($objVserver -eq $null){
				throw "There was an issue while getting the VServer $($VServerName) object.";
			}
			
			if ("$AssembleScriptPath".Trim() -ne "" -and -not ([regex]::Replace($objVserver.AssembleScript, "[`r`n]", {param($match) ""}) -ceq [regex]::Replace($assembleScript, "[`r`n]", {param($match) ""}))){
				$warningMsg = "$($warningMsg)Upon Update, the VServer $($VServerName) Assemble Script is not the expected one. `n`nActual Assemble Script :`n $($objVserver.AssembleScript) `n`n`nExpected Assemble Script :`n $($assembleScript)`n ";
			}
			
			if ($warningMsg -eq ""){
				$returnResultString = "$($SuccessReturnCode)";
				Write-Host "The VServer $($VServerURL) update was successfull.";
			}
		}
		
		if ($warningMsg -ne ""){
			if ($returnResultString -eq ""){
				$returnResultString = "$($warningMsg)";
			}
			else {
				$returnResultString = "$($returnResultString). $($warningMsg)";
			}
		}
	}
	catch {
		$returnResultString = $_;
	}
	finally {
		RemoveModuleReleaseFoundations;
		if ($warningMsg -ne ""){Write-Warning $warningMsg}
		Write-Host "`nFinished.`n--------------------------------------------------------";
	}
	
	return $returnResultString;
}



<#
.SYNOPSIS
Retourne le nom du VServer a partir de son URL.

.PARAMETER File
Fichier .JSON contenant la cle : VServerURL.
Ne pas renseigner si l'argument VServerURL est fourni en parametre.

.PARAMETER VServerURL
URL du VServer.

.OUTPUTS
String : Nom du VServer.

.EXAMPLE 
PS> GetVserverName -VServerURL "http://auto-VSERVER04.croesus.local"
auto-VSERVER04
#>
function GetVserverName
{
	[CmdletBinding()]
	[OutputType([System.String])]
	Param(
		[Parameter(Mandatory=$false, ParameterSetName="FromJsonFile", Position=0)]$File,
		[Parameter(Mandatory=$false, ParameterSetName="FromCmdLine")][ValidateNotNullOrEmpty()][System.String]$VServerURL
	)
	
	#Parameters
	if ($File -ne $null){
		$myFileParamsJson = ConvertFrom-Json -InputObject "$(Get-Content -Raw -Path $File)";
		foreach ($property in $myFileParamsJson.PSObject.Properties) {
			if ($(Get-Command $MyInvocation.MyCommand.Name).Parameters.Keys.Contains($property.Name)){
				Set-Variable -Name $property.Name -Value $property.Value;
			}
		}
	}
	#Parameters
	
	$returnResultString = "";
	$VServerName = ([System.Uri]$VServerURL).Host -replace ".croesus.local", "";
	if ("$VServerName".Trim() -eq ""){$VServerName = $VServerURL}
	
	try {
		ImportModuleReleaseFoundations;
		$objVserver = $null;
		$objVserver = Get-VServer $VServerName;
		if ($objVserver -eq $null){
			throw "There was an issue while getting the VServer $($VServerName) object.";
		}
		
		if ($objVserver -ne $null -and $objVserver.Name -ieq $VServerName){
			$VServerName = $objVserver.Name
		}
	}
	catch {
		Write-Host "$_";
	}
	finally {
		RemoveModuleReleaseFoundations;
	}
	
	return $VServerName;
}



#Export-ModuleMember 
Export-ModuleMember -Function UpdateVserverReference;
Export-ModuleMember -Function UpdateVserverAssembleScript;
Export-ModuleMember -Function EditVserver;
Export-ModuleMember -Function RestartVserver;
Export-ModuleMember -Function StartVserver;
Export-ModuleMember -Function StopVserver;
Export-ModuleMember -Function MigrateVserver;
Export-ModuleMember -Function LoadDatabase;
Export-ModuleMember -Function DumpDatabase;
Export-ModuleMember -Function RenameDump;
Export-ModuleMember -Function GetDumpFileNames;
Export-ModuleMember -Function GetReferenceNames;
