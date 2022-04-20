//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CROES_6794_Copy_of_configurations_simulator
//USEUNIT GDO_2464_Split_Of_BlockTrade

/**
    Tâche                :  TCVE-1410 (GDO-1719)
    Lien                 : https://jira.croesus.com/browse/TCVE-1410 
    Préconditions        : FD_INVESTMENT_SAVING_ACCOUNT = TDB831 niveau FIRME    
    Auteur               :  A.A ; Youlia
    Version de scriptage :	90.18-47   
*/

function GDO_TCVE1410_PresentDollarQuantityInJsonFileForSomeSecurities(){
      var logEtape1, logEtape2, logEtape3,logRetourEtatInitial;
      try {
              //lien dans Jira
              Log.Link("https://jira.croesus.com/browse/TCVE-1410");
           
              //Activate_Inactivate_PrefFirm("FIRM_1","FD_INVESTMENT_SAVING_ACCOUNT","TDB831",vServerOrders);//  dans pref_Activation_Fir_GDO.sj            
              //RestartServices(vServerOrders);
           
              var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
              var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
              var statusExecuted=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1571", "statusExecutedCroes6545", language+client);

              var sqlRepository =folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\Sql\\";
              var sqlFilePath = sqlRepository + "TCVE-1410.sql";
            
              var listOfAccountNumber  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "listOfAccountNumberTCVE1410", language+client);
              var arrayOfAccountNumber = listOfAccountNumber.split("|");
            
              logEtape1 = Log.AppendFolder("Ajouter les ordres --> SQL");
              ExecuteSQLFile(sqlFilePath, vServerOrders);
                         
              Log.PopLogFolder();
              logEtape2 = Log.AppendFolder("Exécuter les ordres nouvellement ajoutés");
              Log.Message("Se connecter à croesus");
              Login(vServerOrders, userNameUNI00, passwordUNI00, language);
              
              Log.message("Aller dans le module Ordres")
              Get_ModulesBar_BtnOrders().Click();
              Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
                                   
              Log.message("Sélectionner tous les ordres nouvellement ajoutés")
              for (i in arrayOfAccountNumber)
                  Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", arrayOfAccountNumber[i],10).Click(-1,-1,skCtrl);
              
              Log.message("Cliquer sur verifier");  
              Get_OrderAccumulator_BtnVerify().Click();
              Delay(30000);
                            
              Log.message("Cocher les 4 ordres");            
              for (i=1; i<5; i++)
                  Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Find("ClrClassName","XamCheckEditor",10).Click();
                  
            
              Log.Message("Cliquer sur Soumettre");      
              Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
              Get_WinAccumulator_BtnSubmit().Click();
              Delay(10000);
              
              Log.Message("Valider que les ordres sont exécutés dans le blotteur");
              var validationResult=0;  
              for (i=0; i<4; i++)                  
                  if(aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statusExecuted)){
                    validationResult ++;
                  };
              
              Log.PopLogFolder();
              logEtape3 = Log.AppendFolder("Validation de fichier JSON");    
              //continuer la validation de fichier JSON, si les 8 comptes ont le statut "exécuté"    
              if(validationResult == 4){
                    Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
                    SSHExecute("CommandeSSHForTCVE1410");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
                    var localDestinationFilePath=folderPath_ProjectSuiteCommonScripts +"ProjectSuiteOrdres\\Ordres\\SSH\\"
                    
                    TryConnexionAndTrustHostKeyThroughWinSCP(vServerOrders);                                          
                    //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON )       
                    var vserverFilePath="/home/crweb/Test_CR1571/SearchResultsTCVE1410.txt" 
                    var vserverFilePathJson="/home/crweb/Test_CR1571/JSONTCVE1410.txt"           
                    CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
                    CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePathJson, localDestinationFilePath);
                                         
                    
                    //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
                    var listOfResults  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "listOfResultsTCVE1410", language+client);//"2|4|2|1|1|1|1|1|1|1|1";
                    var arrayOfResults = listOfResults.split("|");
              
                    // Déclaration de string recherchés
                    var listOfStringTofind  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "listOfStringTofindTCVE1410", language+client);
                    var arrayOfStringTofind = listOfStringTofind.split("|");
            
                    //Validation du fichier JSON
                    var myFile = aqFile.OpenTextFile(localDestinationFilePath+"SearchResultsTCVE1410.txt", aqFile.faRead, aqFile.ctANSI);                 
                    while(! myFile.IsEndOfFile()){    
                        line = myFile.ReadLine();
                        //Split at each space character.
                        var JSONArr = line.split("\n"); 
                        Log.Message(line)      
                            for (i=0 ;i< JSONArr.length; i++){
                                if(aqObject.CompareProperty(VarToString(JSONArr[i]),cmpEqual,VarToString(arrayOfResults[i]),true,lmError)){
                                      Log.Checkpoint("Le texte "+ arrayOfStringTofind[i]+ " présente " + JSONArr[i] + " fois dans le fichier JSON" )
                                } 
                                else{
                                      Log.Error("Le texte "+ arrayOfStringTofind[i] +" ne présente pas " + arrayOfResults[i] + " fois dans le fichier JSON")
                                } ;
                            };
                    }; 
              }else{
                Log.Error("les ordres ne sont pas exécutés dans le blotteur");
              };
            
            Terminate_CroesusProcess();
            
            //sauvgarder le fichier JSON sur P:
            var referenceName = GetVServerReference(vServerOrders);
            var executionEndDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y_%m_%d %H_%M_%S");
            var folderName = "OrdresJSONFile";    
            var logFolderPath = logRootFolderPath + referenceName + "\\" + folderName + "_" + executionEndDateTimeString + "\\";                    
            var vserverFilePath=aqString.Trim(jsonPath(localDestinationFilePath), aqString.stAll);
            Log.Message("Save Json to: " + logFolderPath);
            TryConnexionAndTrustHostKeyThroughWinSCP(vServerOrders);
            CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, logFolderPath); 
             
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));

      }
      finally {
            Log.PopLogFolder();
            logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");       
            Login(vServerOrders, userNameUNI00, passwordUNI00, language);
            Log.message("Aller dans le module Ordres")
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
            DeleteAllOrdersInAccumulator();  
            Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
            Runner.Stop(true);   
        }
}

function jsonPath(localDestinationFilePath){   
   var myFile = aqFile.OpenTextFile(localDestinationFilePath+"JSONTCVE1410.txt", aqFile.faRead, aqFile.ctANSI);                 
   while(! myFile.IsEndOfFile()){    
        jsonPath = myFile.ReadLine();
        Log.Message(jsonPath)  
        return jsonPath    
   };        
}


