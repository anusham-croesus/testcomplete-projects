//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables


/**    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Sana Ayaz, A.A    
*/

function CR1827_PreparationBD_GPD()  {
    
        try {   
            //Mise à jour de la BD
            var SQLQuery_B_def1 = "update b_def set DEFAULT_VALUE='2002.06.30' where cle = 'PREF_REPORT_GPD_FATCA_DATE'";		
            var SQLQuery_B_def2 = "update b_def set DEFAULT_VALUE='2002.06.30' where cle = 'PREF_REPORT_GPD_NCD_DATE'";		
    
            var SQLQuery_B_addrss1  = "update b_addrss set COUNTRY='West Australia' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182705')";		
            var SQLQuery_B_addrss2  = "update b_addrss set COUNTRY='États Unis' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182708')";		
            var SQLQuery_B_addrss3  = "update b_addrss set COUNTRY='Germany' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182711')";		
            var SQLQuery_B_addrss4  = "update b_addrss set COUNTRY='ANDORRE' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182717')";		
            var SQLQuery_B_addrss5  = "update b_addrss set COUNTRY='Danemark' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182718')";		
            var SQLQuery_B_addrss6  = "update b_addrss set COUNTRY='Belgique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182719')";		
            var SQLQuery_B_addrss7  = "update b_addrss set COUNTRY='Mexique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182720')";		
            var SQLQuery_B_addrss8  = "update b_addrss set COUNTRY='New Zealand' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182721')";		
            var SQLQuery_B_addrss9  = "update b_addrss set COUNTRY='Argentina' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182723')";		
            var SQLQuery_B_addrss10 = "update b_addrss set COUNTRY='Espagne' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182725')";		
            var SQLQuery_B_addrss11 = "update b_addrss set COUNTRY='France' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182726')";		
            var SQLQuery_B_addrss12 = "update b_addrss set COUNTRY='Venezuela' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182728')";		
            var SQLQuery_B_addrss13 = "update b_addrss set COUNTRY='Chili' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182744')";		
            var SQLQuery_B_addrss14 = "update b_addrss set COUNTRY='United Arab Emi' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182745')";		
            var SQLQuery_B_addrss15 = "update b_addrss set COUNTRY='Finland' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182746')";		
            var SQLQuery_B_addrss16 = "update b_addrss set COUNTRY='Equatorial Guin' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182747')";		
            var SQLQuery_B_addrss17 = "update b_addrss set COUNTRY='Ireland' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182748')";		
            var SQLQuery_B_addrss18 = "update b_addrss set COUNTRY='Luxembourg' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182750')";		
            var SQLQuery_B_addrss19 = "update b_addrss set COUNTRY='Maurice' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182751')";		
            var SQLQuery_B_addrss20 = "update b_addrss set COUNTRY='Mozambique' where ADDRESS_ID in (select ADDRESS_ID from b_claddr  where no_client='182752')";
    				
            var SQLQuery_B_trans = "update b_trans set IS_PROC=NULL where NO_COMPTE in('182744-BN','182744-BO','182744-BP','182745-BQ','182746-BT','182747-BW','182748-BZ','182750-CF',"
                            + "'182751-CI','182752-CL','182752-CM','182752-CN','182757-DA','182762-DP','182763-DS','182764-DV')"	                            

            Log.Message("Mise à jour de la BD");
            Execute_SQLQuery(SQLQuery_B_trans, vServerReportsCR1485);
    
            Execute_SQLQuery(SQLQuery_B_def1, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_def2, vServerReportsCR1485);
  
            Execute_SQLQuery(SQLQuery_B_addrss1, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss2, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss3, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss4, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss5, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss6, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss7, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss8, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss9, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss10, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss11, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss12, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss13, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss14, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss15, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss16, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss17, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss18, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss19, vServerReportsCR1485);
            Execute_SQLQuery(SQLQuery_B_addrss20, vServerReportsCR1485);
     
            Activate_Inactivate_PrefFirm("FIRM_1", "FD_TAXEVASION_DECLARABLE_ACC", "AA,AC,AD,AE,AG,AI,AJ,AK,AM,AO,AP,AQ,AS,AU,AV,AW,AY,AZ,BB,BC,BE,BF,BH,BI,BK,BL,BN,BO,BQ,BR,BT,BU,BW,BX,BZ,CA,CD,CF,CG,CI,CJ,CL,CM,CO,CP,CQ,CR,CS,CU,CV,CX,CY,DA,DD,DG,DL,DM,DP,DS,DV", vServerReportsCR1485); 
    
            Log.Message("Redémarrage des services");
            RestartServices(vServerReportsCR1485); 
    
            ExecuteSSHFile(vServerReportsCR1485, "extractsGPD.sh");
        }
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            
        }
}

function ExecuteSSHFile(vServerURL, sshCommandFile)
{
        var hostname = GetVserverHostName(vServerURL);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        //    var executionDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
        var filesRootName = "extractsGPD_";// + executionDateTimeString;
  
        Log.Message("ExecuteSSHCommand on " + hostname);
    
        var SSHCmdFileName = sshCommandFile;
        var localOutputFileName = filesRootName + "_Output.txt";
        var localOutputFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).Path + "\\Rapports\\" + localOutputFileName;
        var plinkBatchFilePath  = aqFileSystem.GetFolderInfo(ProjectSuite.Path).Path + "\\Rapports\\" + filesRootName + "_Plink.bat";

        //Cleanup existing Files    
        if (aqFileSystem.Exists(plinkBatchFilePath))
            aqFileSystem.DeleteFile(plinkBatchFilePath);
    
        if (aqFileSystem.Exists(localOutputFilePath))
            aqFileSystem.DeleteFile(localOutputFilePath);
   
        //Create and Execute Plink batch file
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > " + localOutputFileName;
        if (!aqFile.WriteToTextFile(plinkBatchFilePath, batchCmdLine, aqFile.ctANSI, true))
            Log.Error("File creation was not successfull : " + plinkBatchFilePath, batchCmdLine);
    
        ExecuteBatchFile(plinkBatchFilePath);
    
        //Récupérer le Output
        if (!aqFileSystem.Exists(localOutputFilePath)){
            Log.Error("Local Output file not found : " + localOutputFilePath, localOutputFilePath);
            return null;
    }
}


