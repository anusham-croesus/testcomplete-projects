//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
 
Analyste d'automatisation: Youlia Raisper */


function Preparation()
{
    try{  
                 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerModeles)  
        Execute_SQLQuery("update b_config set  NOTE ='2009.01.30' where cle ='FD_LASTTRA'", vServerModeles) 
           
        //Create PLINK batch file
        var hostname = GetVserverHostName(vServerModeles);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_preparation_model2.txt > ssh_preparation_model2_output.txt";
        var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteModeles\\Modeles\\SSH\\ssh_preparation_model2_plink.bat";
        CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
        //Execute PLINK batch file (The PLINK application must be present in the same folder)
        ExecuteBatchFile(plinkBatchFilePath);
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {         
	    Runner.Stop(true);      
    }
}