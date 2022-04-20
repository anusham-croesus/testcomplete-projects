<#
.SYNOPSIS
Cette fonction retourne un objet Reference.

.DESCRIPTION
Cette fonction retourne un objet Reference ou null s'il n'est pas trouvé.

.EXAMPLE
$reference = Get-Reference
La variable $reference contiendra l'information concernant l'ensemble des références.
#>
function Get-Reference{
    $error.Clear()

    $devopsDeploymentTypePath = Get-ReleaseFoundationsPath
    
    if ($devopsDeploymentTypePath -eq "")
    {
        return
    }

    Add-Type -Path "$devopsDeploymentTypePath" -Verbose
    
    if ($error.Count -gt 0) {exit}

	$urlBuilder = New-Object ReleaseFoundations.Release.Web.UrlBuilder -ArgumentList $null,$null
	$references = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshReferences($urlBuilder)

	return $references
}

<#
.SYNOPSIS
Cette fonction retourne un objet Master.

.DESCRIPTION
Cette fonction retourne un objet Master ou null s'il n'est pas trouvé.

.EXAMPLE
$master = Get-Master
La variable $master contiendra l'information concernant l'ensemble des masters.
#>
function Get-Master{
	Param([Parameter(Mandatory=$true)][ValidateSet("dev", "qa", "demo", "ventes")][System.String]$Group,
		  [Parameter(Mandatory=$false)][System.String]$MasterName)

		$error.Clear()

		$devopsDeploymentTypePath = Get-ReleaseFoundationsPath
    
		if ($devopsDeploymentTypePath -eq "")
		{
			return
		}

		Add-Type -Path "$devopsDeploymentTypePath" -Verbose
    
		if ($error.Count -gt 0) {exit}

		$urlBuilder = New-Object ReleaseFoundations.Release.Web.UrlBuilder -ArgumentList $null,$null

		if ($MasterName -eq $null -or $MasterName -eq "")
		{
			$masters = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshMasters($Group, $urlBuilder)
		}
		else
		{
			$masters = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshMasters($Group, $urlBuilder, $MasterName)
		}

		return $masters
}

<#
.SYNOPSIS
Cette fonction retourne un objet Database.

.DESCRIPTION
Cette fonction retourne un objet Database ou null s'il n'est pas trouvé.

.EXAMPLE
$database = Get-Database
La variable $database contiendra l'information concernant l'ensemble des databases.
#>
function Get-Database{
	Param([Parameter(Mandatory=$true)][ValidateSet("dev", "doc", "nfr", "qa", "ventes", "demo")][System.String]$Group,
		  [Parameter(Mandatory=$false)][System.String]$DatabaseName)

		$error.Clear()

		$devopsDeploymentTypePath = Get-ReleaseFoundationsPath
    
		if ($devopsDeploymentTypePath -eq "")
		{
			return
		}

		Add-Type -Path "$devopsDeploymentTypePath" -Verbose
    
		if ($error.Count -gt 0) {exit}
		
		$urlBuilder = New-Object ReleaseFoundations.Release.Web.UrlBuilder -ArgumentList $null,$null
	
		if ($DatabaseName -eq $null -or $DatabaseName -eq "")
		{
			$databases = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshDatabases($urlBuilder, $Group)
		}
		else
		{
			$databases = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshDatabases($urlBuilder, $Group, $DatabaseName)
		}
		return $databases
}

<#
.Synopsis
   Cette fonction retourne un objet VServer.
.DESCRIPTION
   Cette fonction retourne un objet VServer ou null s'il n'est pas trouvé.
.PARAMETER VServerName
   Nom du V-Server à retourner.
.EXAMPLE
   $vserver = Get-VServer "dev-mainline"
   La variable $vserver contiendra l'information concernant le V-Server "dev-mainline".
#>
function Get-VServer{
     Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName)
        
        $error.Clear()

        $devopsDeploymentTypePath = Get-ReleaseFoundationsPath

        if ($devopsDeploymentTypePath -eq "")
        {
            return
        }

        Add-Type -Path "$devopsDeploymentTypePath" -Verbose

        if ($error.Count -gt 0) {exit}

        $group = Get-DeploymentGroup $VServerName

		$vservers = [ReleaseFoundations.ReleaseFoundationsApi]::RefreshVServers($group)

        foreach($vserver in $vservers)
        {
            if($VServerName -eq $vserver.Name)
            {
                return $vserver
            }
        }
        return $null        
}

<#
.Synopsis
   Cette fonction mets a jour le statut d'un VServer.
.DESCRIPTION
   Cette fonction mets a jour le statut d'un VServer.
.PARAMETER VServer
   V-Server à mettre a jour.
.EXAMPLE
   Update-VServer $vserver
   Le V-Server $vserver sera mis a jour.
#>
function Update-VServer{
     Param([Parameter(Mandatory=$true)]$VServer)
        
        $error.Clear()

        $devopsDeploymentTypePath = Get-ReleaseFoundationsPath

        if ($devopsDeploymentTypePath -eq "")
        {
            return
        }

        Add-Type -Path "$devopsDeploymentTypePath" -Verbose

        if ($error.Count -gt 0) {exit}
       
		if ($VServer -eq $null)
		{
			Write-Error "V-Server passed in argument is invalid. It cannot be null."
			exit
		}
		
		[ReleaseFoundations.ReleaseFoundationsApi]::UpdateVServerStatus($VServer);

        Write-Output $($vserver.StartInfoLog)        
}

<#
.Synopsis
   Cette fonction démarre un VServer.
.DESCRIPTION
   Cette fonction démarre un VServer.
.PARAMETER VServerName
   Nom du V-Server à démarrer.
.EXAMPLE
   Start-VServer "dev-mainline"
   Le V-Server "dev-mainline" sera démarré.
#>
function Start-VServer{
     Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName)
        
        $error.Clear()

        $devopsDeploymentTypePath = Get-ReleaseFoundationsPath

        if ($devopsDeploymentTypePath -eq "")
        {
            return
        }

        Add-Type -Path "$devopsDeploymentTypePath" -Verbose

        if ($error.Count -gt 0) {exit}

        $vserver = Get-VServer $VServerName
		[ReleaseFoundations.ReleaseFoundationsApi]::StartVServer($vserver);

        Write-Output $($vserver.StartInfoLog)

        if ($vserver.IsRunning)
        {
            if ( ($($vserver.StartErrLog)) -ne "")
            {
                Write-Warning $($vserver.StartErrLog)
            }
            Write-Output "V-Server $VServerName started successfully."
        }
        else
        {
            Write-Error $($vserver.StartErrLog)
            Write-Error "V-Server $VServerName was unable to start."
        }
}

<#
.Synopsis
   Cette fonction arrête un VServer.
.DESCRIPTION
   Cette fonction arrête un VServer.
.PARAMETER VServerName
   Nom du V-Server à arrêter.
.EXAMPLE
   Stop-VServer "dev-mainline"
   Le V-Server "dev-mainline" sera arrêté.
#>
function Stop-VServer{
     Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName)
        
        $error.Clear()

        $devopsDeploymentTypePath = Get-ReleaseFoundationsPath

        if ($devopsDeploymentTypePath -eq "")
        {
            return
        }

        Add-Type -Path "$devopsDeploymentTypePath" -Verbose

        if ($error.Count -gt 0) {exit}

        $vserver = Get-VServer $VServerName

		[ReleaseFoundations.ReleaseFoundationsApi]::StopVServer($vserver);

        Write-Output $($vserver.StopInfoLog)

        if (-not($vserver.IsRunning))
        {
            if ( ($($vserver.StopErrLog)) -ne "")
            {
                Write-Warning $($vserver.StopErrLog)
            }
            Write-Output "V-Server $VServerName stopped successfully."
        }
        else
        {
            Write-Error $($vserver.StopErrLog)
            Write-Error "V-Server $VServerName was unable to stop."
        }
}

<#
.Synopsis
   Cette fonction redémarre un VServer.
.DESCRIPTION
   Cette fonction redémarre un VServer. Cette commande est l'équivalent de faire Stop-VServer et Start-VServer.
.PARAMETER VServerName
   Nom du V-Server à redémarrer.
.EXAMPLE
   Restart-VServer "dev-mainline"
   Le V-Server "dev-mainline" sera arrêté et démarré. 
#>
function Restart-VServer{
     Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName)
        
        Stop-VServer $VServerName
		Start-VServer $VServerName
}

<#
.Synopsis
   Cette fonction édite un VServer. Après l'édition, le V-Server doit être redémarré.
.DESCRIPTION
   Cette fonction édite un VServer. Après l'édition, le V-Server doit être redémarré.
.PARAMETER VServerName
   Nom du V-Server à éditer.
.PARAMETER Master
   Nom du master sur lequel le V-Server doit rouler.
.PARAMETER Reference
   Nom de la référence à utiliser par le V-Server.
.PARAMETER Database
   Nom de la base de donnée à utiliser dans le format nombd@serveurbd.
.PARAMETER AssembleScript
   Script qui sera utilisé au Start du V-Server comme Assemble Script.
.EXAMPLE
   Edit-VServer "dev-mainline" -Database "dev_syb78@devrefbd" 
   Le V-Server "dev-mainline" change de base de donnée pour dev_syb78 situé sur le serveur devrefbd. 
#>
function Edit-VServer{
     Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName,
           [Parameter(Mandatory=$false)][System.String]$Master = "",
           [Parameter(Mandatory=$false)][System.String]$Reference = "",
           [Parameter(Mandatory=$false)][System.String]$Database = "",
           [Parameter(Mandatory=$false)][System.String]$AssembleScript = "")
        
	    $error.Clear()

        $devopsDeploymentTypePath = Get-ReleaseFoundationsPath

        if ($devopsDeploymentTypePath -eq "")
        {
            return
        }

        Add-Type -Path "$devopsDeploymentTypePath" -Verbose

        if ($error.Count -gt 0) {exit}

        $parametersEdit =  New-Object -TypeName "System.Collections.Generic.Dictionary``2[[string],[string]]"
      
        if ($PSBoundParameters.ContainsKey('Master'))
        {
            $parametersEdit.Add([ReleaseFoundations.Release.Container.VServerConstants]::EditVServerPropertyKey_Master, "$Master")          
        }

        if ($PSBoundParameters.ContainsKey('Database'))
        {
            $parametersEdit.Add([ReleaseFoundations.Release.Container.VServerConstants]::EditVServerPropertyKey_DB, $Database)    
        }

        if ($PSBoundParameters.ContainsKey('Reference'))
        {
            $parametersEdit.Add([ReleaseFoundations.Release.Container.VServerConstants]::EditVServerPropertyKey_Reference, $Reference)    
        }

        if ($PSBoundParameters.ContainsKey('AssembleScript'))
        {
            $parametersEdit.Add([ReleaseFoundations.Release.Container.VServerConstants]::EditVServerPropertyKey_Script, $AssembleScript)    
        }
	
        $vserver = Get-VServer $VServerName
        
        try {
			[ReleaseFoundations.ReleaseFoundationsApi]::EditVServer($vserver, $parametersEdit);
        }
        catch
        {
            throw $_.Exception
            exit
        }

        if($Master -ne "")
        {
            Write-Output "The new master for $($vserver.Name) is $($vserver.Master)."
        }

        if($Database -ne "")
        {
            Write-Output "The new DB for $($vserver.Name) is $($vserver.DatabaseName)@$($vserver.Databaseserver)."    
        }

        if($Reference -ne "")
        {
            Write-Output "The new reference for $($vserver.Name) is $($vserver.Reference.Name)."    
        }

        if($AssembleScript -ne "")
        {
            Write-Output "The new AssembleScript for $($vserver.Name) is:"
            Write-Output "$($vserver.AssembleScript)"    
        }
        
}

#
# PRIVATE FUNCTIONS.
#

function Get-ReleaseFoundationsPath{

    if (Test-Path ".\ReleaseFoundations.dll")
    {
        return ".\ReleaseFoundations.dll"
    }
    elseif (Test-Path "$PSScriptRoot\ReleaseFoundations.dll")
    {
        return "$PSScriptRoot\ReleaseFoundations.dll"
    }
    elseif (Test-Path "$PSScriptRoot\bin\Debug\ReleaseFoundations.dll")
    {
        return "$PSScriptRoot\bin\Debug\ReleaseFoundations.dll"
    }
    
    Write-Error "Can't find ReleaseFoundations.dll"       
    return ""
}

function New-VServer{
    Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$VServerName)
        
        $urlBuilder = New-Object ReleaseFoundations.Release.Web.UrlBuilder -ArgumentList $null,$null
        $constants = New-Object ReleaseFoundations.Release.Container.VServerConstants
		$stringToAscii = New-Object ReleaseFoundations.Release.Web.AsciiToStringConverter

        #Find the group automatically.
        $group = Get-DeploymentGroup $VServerName        

        $vserver = New-Object ReleaseFoundations.Release.Container.VServer 
        if ($error.Count -gt 0) {exit}

        return $vserver
}

function Get-DeploymentGroup{
    Param([Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][System.String]$DeploymentGroupName)
        
        if ($DeploymentGroupName.StartsWith([ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Dev))
        {
            return [ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Dev
        }
        elseif ($DeploymentGroupName.StartsWith([ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Demo))
        {
            return [ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Demo
        }
        if ($DeploymentGroupName.StartsWith([ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_QA))
        {
            return [ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_QA
        }
        if ($DeploymentGroupName.StartsWith([ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Ventes))
        {
            return [ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Ventes
        }
		if ($DeploymentGroupName.StartsWith([ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Auto))
        {
            return [ReleaseFoundations.Release.DeploymentConstants]::DeploymentGroup_Auto
        }
        return ""
}

# EXPORTS.
Export-ModuleMember -Function 'Start-VServer'
Export-ModuleMember -Function 'Stop-VServer'
Export-ModuleMember -Function 'Edit-VServer'
Export-ModuleMember -Function 'Restart-VServer'
Export-ModuleMember -Function 'Get-VServer'
Export-ModuleMember -Function 'Get-Reference'
Export-ModuleMember -Function 'Get-Database'
Export-ModuleMember -Function 'Get-Master'
Export-ModuleMember -Function 'Update-VServer'