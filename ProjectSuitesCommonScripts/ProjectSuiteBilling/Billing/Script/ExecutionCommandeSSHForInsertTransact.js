//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables


/* Description : 
Injection des transactions pour le bon fonctionnement des scripts de billing
Le lient qui contient les transactions sous forme d'un fichier xml est : P:\aq\Projets\US\CR's V9\CR1394\Tests auto\CR1394
Nom du fichier est : CompletCAD.xml

Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function ExecutionCommandeSSHForInsertTransact()
  {
   try {
  
    //Create PLINK batch file
    hostname = GetVserverHostName(vServerBilling);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    //batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m CommandeSSHForInsertTransac.txt >output_CommandeSSHForInsertTransac.txt";
    
    var fichierCommandeSSHForInsertTransac = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteBilling\\Billing\\CommandeSSHForInsertTransac.txt";
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m \"" + fichierCommandeSSHForInsertTransac + "\" >output_CommandeSSHForInsertTransac.txt";
    plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "plink_CommandeSSHForInsertTransac.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
	
  
}
catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        
    }
} 
   