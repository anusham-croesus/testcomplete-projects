//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
Sous WinSCP/SSH, le dossier /var/lib/ est utilisé pour stocker les configurations qui seront utilisées dans la mise en place, ainsi que le dossier du Simulateur (qui agit en remplacement du fournisseur externe dans un contexte de test).
Si le dossier ne contient pas les dossiers nécessaires, une copie à jour est conservée sur le réseau interne.
 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6794
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6795
    Analyste d'automatisation : Youlia Raisper
    
    Version de scriptage:	15-2020-3-112 (bd de TD)
*/
function CROES_6794_Copy_of_configurations_simulator(){
    
    CROES_6794_Configurations_simulator();
}


function CROES_6794_Configurations_simulator()
{
    try {
        
          var remoteDestinationFolder="/var/lib/finansoft";
          var localFolderPath="\\\\srvfs1\\pub\\divers\\aq\\FixSimulator\\Config_FixStores_Simulator\\"
          var listOfFolders  = "configs|FIXStores|Simulator|";
          var arrayOfFolders = listOfFolders.split("|");
          
          var localFolderPathAddSentExtension=folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\" 
            
          Log.Message("copier les dossiers");
          TryConnexionAndTrustHostKeyThroughWinSCP(vServerOrders);
          
          for (i in arrayOfFolders)
              CopyFileToVserverThroughWinSCP(vServerOrders, remoteDestinationFolder, localFolderPath + arrayOfFolders[i]);
                            
          Log.Message("mettre le fichier dans AddSentExtension.sh /etc/finansoft/");
          CopyFileToVserverThroughWinSCP(vServerOrders, "/etc/finansoft/", localFolderPathAddSentExtension + "AddSentExtension.sh");
          
          
          Log.Message("Modifier le fichier dans var/lib/finansoft/configs et celui dans etc/finansoft");
          SSHExecute("CommandeSSHForCROES6795_1");
          Delay(2000);
          SSHExecute("CommandeSSHForCROES6795_2");

          Log.Message("Executer SQL  update b_routing set sup_id = 5 where fin_instrument = 1");
          Execute_SQLQuery("update b_routing set sup_id = 5 where fin_instrument = 1", vServerOrders); 
                        
          /*yes | cp /var/lib/finansoft/configs/* /etc/finansoft
          service cffixproxy restart
          cd /var/lib/finansoft/Simulator
          mono --debug Simulator.exe >Simulator.log 2>&1 &
          service cfordermanagementserver restart
          ps -ef | grep mono*/
 
          SSHExecute("CommandeSSHForCROES6795");           
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {

    }
}

function SSHExecute(txtFile){
       //Create PLINK batch file
        var hostname = GetVserverHostName(vServerOrders);
        var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
        var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m "+txtFile+".txt > "+txtFile+"_output.txt";
        var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\"+txtFile+"_plink.bat";
        CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
        //Execute PLINK batch file (The PLINK application must be present in the same folder)
        ExecuteBatchFile(plinkBatchFilePath);
}

