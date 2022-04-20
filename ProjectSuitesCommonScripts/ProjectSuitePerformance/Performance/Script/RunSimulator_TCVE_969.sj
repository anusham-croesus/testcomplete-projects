//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      
      Analyste d'automatisation: Youlia R*/

function RunSimulator_TCVE_969(){
    try{
      
           var remoteDestinationFolder="/root/";
           var localFolderPath=folderPath_Data+"CIBC\\SimulatorNbrUsers\\" //Le remplacement de fichier qui contient des utilisateurs 50/75/100
           var resultLogFile="loadsimulator.csv" // le nom de fichier log généré sur le vserveur âpres le lancement de simulateur
           var durationSimulator="1000" //la durée de simulation 
           
           SetNotReadOnlyAttributeToFile (folderPath_Data,"data_Performance.xlsx");
           SetNotReadOnlyAttributeToFile (localFolderPath,"data_Performance_Simulateur.xlsx");
           
           if(numberOfUsers!="Default"){
             
                Log.Message("L'exécution sera exécutée avec la simulation de "+ numberOfUsers +"[ avec le plugin -SIMULATOR]");
                if (TryConnexionAndTrustHostKeyThroughWinSCP(vServerPerformance)){
                    //L'etape 1 
                    Log.Message("copier les fichier.csv qui contient le nombre d'utilisateurs  désirés et le mettre dans /root/ de vserveur");
                    CopyFileToVserverThroughWinSCP(vServerPerformance, remoteDestinationFolder, localFolderPath + "users"+numberOfUsers+".csv");
             
                    //L'etape 2
                    Log.Message("Lancer le simulateur. La simulation va durer "+ durationSimulator  +"minutes.") 
                    ExeSSHCommand("", vServerPerformance, "cfLoader -LoadSimulator --userfile=users"+numberOfUsers+".csv --duration="+durationSimulator, "root");
              
                    
                    Delay(120000); //il faut attendre au moins 2 minutes pour que le fichier loadsimulator.csv apparaisse sur le vserveur  
                    Log.Message("Vérifier que le simulateur a été lancé");
                    if(ExecuteWinSCPCommand(vServerPerformance, '"get ""' + remoteDestinationFolder+resultLogFile + '"""')){
                      Log.Checkpoint("Le simulateur a été lancé")
                    }else{
                      Log.Error("Le simulateur n'a pas été lancé");                  
                    };
                
                    //laisser rouler le simulateur 15 min 
                    Delay(900000);  
                }else{
                  Log.Error("L'exécution a été arrêtée parce que la connexion au vserver  n'a pas été établie.");
                  Runner.Stop(false);//Specifies whether the method stops execution of the current test only or the whole test run.
                }                           
           }
           else{
             Log.Message("L'exécution sera exécutée sans le plugin -SIMULATOR ");             
           };                     
    }        
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
              
    }
}


function SetNotReadOnlyAttributeToFile (Folder,FileName) 
{
 /*Verifier l'existance du fichier*/
  var FileExiste = CheckIfFileExists(Folder,FileName)
  if(FileExiste != null) 
     {
         var state = aqFile.GetFileAttributes(Folder+FileName);
         if (state != 32)//si read only
           {
              Log.Message("Le fichier "+FileName+" est en lecture seule");
              Log.Message("Enlever la lecture seule du fichier"+FileName);
              aqFile.SetFileAttributes(Folder+FileName,32);
           }  
     }
}

function ExeSSHCommand(CRFolderOrSSHCommandId, vServerURL, sshCommand, username, outputSuccessRegEx)//work
{
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var executionDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
    var filesRootName = (CRFolderOrSSHCommandId != undefined)? CRFolderOrSSHCommandId: "ExecuteSSHCommand" + executionDateTimeString;
    
    var executionSSHCommands = "#!/bin/bash" + "\r\n";
    executionSSHCommands += "if [ -f '/home/tools/LOG_cfLoader.sh' ]; then sh /home/tools/LOG_cfLoader.sh; fi" + "\r\n" + "\r\n";
    
    if (CRFolderOrSSHCommandId != undefined && username != undefined){
        var filesRootName = CRFolderOrSSHCommandId + executionDateTimeString;
        var vserverFolder = username// + CRFolderOrSSHCommandId ;
        //executionSSHCommands += "mkdir -p " + vserverFolder + "\r\n";
        //executionSSHCommands += "cd " + vserverFolder + "\r\n\r\n";
    }
    
    executionSSHCommands += sshCommand + "\r\n";
    
    Log.Message("ExecuteSSHCommand() on " + hostname + " : " + sshCommand, executionSSHCommands);
    
    var SSHCmdFileName = filesRootName + ".sh";
    var SSHCmdFilePath =  folderPath_ProjectSuiteCommonScripts + SSHCmdFileName;
    var localOutputFileName = filesRootName + "_Output.txt"; 
    var localOutputFilePath =  folderPath_ProjectSuiteCommonScripts + localOutputFileName; 
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + filesRootName + "_Plink.bat";
    
    //Cleanup existing Files
    if (aqFileSystem.Exists(SSHCmdFilePath))
        aqFileSystem.DeleteFile(SSHCmdFilePath);
    
    if (aqFileSystem.Exists(plinkBatchFilePath))
        aqFileSystem.DeleteFile(plinkBatchFilePath);
    
    if (aqFileSystem.Exists(localOutputFilePath))
        aqFileSystem.DeleteFile(localOutputFilePath);
    
    //Create SSH file
    if (!aqFile.WriteToTextFile(SSHCmdFilePath, executionSSHCommands, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + SSHCmdFilePath, executionSSHCommands);
    
    //Create and Execute Plink batch file
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > " + localOutputFileName;
    if (!aqFile.WriteToTextFile(plinkBatchFilePath, batchCmdLine, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + plinkBatchFilePath, batchCmdLine);
    
    ExeBatchFile(plinkBatchFilePath);
    
    
//        
//    //Récupérer le Output
//    if (!aqFileSystem.Exists(localOutputFilePath)){
//        Log.Error("Local Output file not found : " + localOutputFilePath, localOutputFilePath);
//        return null;
//    }
//    
//    var localOutputFileContent = Trim(aqFile.ReadWholeTextFile(localOutputFilePath, aqFile.ctUTF8));
//    Log.Message("ExecuteSSHCommand() Output for : " + sshCommand, localOutputFileContent);
//    
//    if (outputSuccessRegEx != undefined){
//        if (aqString.StrMatches(outputSuccessRegEx, localOutputFileContent)){
//            Log.CallStackSettings.EnableStackOnCheckpoint = true;
//            Log.Checkpoint("Success. Regular Expression matched in the SSH command execution output.", "Regular Expression is : \r\n\r\n" + outputSuccessRegEx);
//            Log.CallStackSettings.EnableStackOnCheckpoint = false;
//        }
//        else {
//            Log.Error("Regular Expression not matched in the SSH command execution output.", "Regular Expression is : \r\n\r\n" + outputSuccessRegEx);
//        }
//    }
//    
//    return localOutputFileContent;
}

function ExeBatchFile(batchFilePath)
{
    Log.Message("Execute batch file : " + batchFilePath);
    
    var defaultCurrentFolder = aqFileSystem.GetCurrentFolder();
    var batchFileFolderPath = aqFileSystem.GetFileInfo(batchFilePath).ParentFolder.Path;
    
    //Log.Message("Set current folder to : " + batchFileFolderPath);
    aqFileSystem.SetCurrentFolder(batchFileFolderPath);
    
    batchFilePath = "\"" + batchFilePath + "\"";
    
    //Log.Message("Execute file : " + batchFilePath);
    var shellObj = (isJavaScript())? getActiveXObject("WScript.Shell"): Sys.OleObject("WScript.Shell");
    shellObj.Run(batchFilePath, 1, false);
    //2eme paramètre de Run : 0 = n'affiche pas de fenêtre DOS ; 1 = affiche une fenêtre DOS (défaut)
    //3eme paramètre de Run : true = attend la fin de l'exécution ; false = n'attend pas la fin de l'exécution (défaut)
    
    //Log.Message("Set current folder back to : " + defaultCurrentFolder);
    aqFileSystem.SetCurrentFolder(defaultCurrentFolder);
}



