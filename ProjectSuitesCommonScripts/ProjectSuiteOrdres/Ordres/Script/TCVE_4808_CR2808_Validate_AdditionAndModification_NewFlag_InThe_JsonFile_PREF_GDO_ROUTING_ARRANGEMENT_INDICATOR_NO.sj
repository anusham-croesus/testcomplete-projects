//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2456_FundReport
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CROES_6794_Copy_of_configurations_simulator
//USEUNIT TCVE_4808_CR2808_Validate_AdditionAndModification_NewFlagInThe_JsonFile



/*Description : Le but de ce cas est de Valider l'ajout et la modification de nouveau flag dans le fichier json.
avec la pref "PREF_GDO_ROUTING_ARRANGEMENT_INDICATOR","NO"

 
    Analyste d'assurance qualité: Karima Mo.
    Analyste d'automatisation: Alhassane Diallo.
    ref 90.24.2021.04-13 */  
 
 function TCVE_4808_CR2808_Validate_AdditionAndModification_NewFlag_InThe_JsonFile_PREF_GDO_ROUTING_ARRANGEMENT_INDICATOR_NO()
 {             
    try{  

          
                  
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-4706","Lien de la story dans Jira", "TCVE-4706");
           
           Log.PopLogFolder();
           logEtape0 = Log.AppendFolder("Étape 0: Pre_condition du cas de test"); 
           
           //Activation des prefs
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_ROUTING_ARRANGEMENT_INDICATOR","NO",vServerOrders);
           RestartServices(vServerOrders)
           SSHExecute("CommandeSSHForCROES6795");
           
    
           //Declaration des Variables
           var userNameKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
                    
           var account800049NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800049NA", language+client);

           var quantityYHOO           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_YHOO", language+client);
           var securityYHOO           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_YHOO", language+client);
           var note_1                 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "NOTE", language+client);
           var item                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
             
           
           //Se connecter à croesus avec Keynej
           Log.PopLogFolder();
           logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej"); 
           Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language); 
             
            
           Log.PopLogFolder();
           logEtape2 = Log.AppendFolder("Étape 2: Selectionner le compte 8000049-NA, puis Ajouter un ordre de vente "); 
           
                 
           //Valider que Accamulator est vide 
           Log.Message("Valider que Accamulator est vide");
           Get_ModulesBar_BtnOrders().Click();
           DeleteAllOrdersInAccumulator();
        
           //Acceder au Module Compte
           Log.Message("Acceder au Module Compte");
           Get_ModulesBar_BtnAccounts().Click();
           Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
           //Selectionner le compte 8000049-NA
           Log.Message("Selectionner le compte 8000049-NA");
           SearchAccount(account800049NA);  
           Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800049NA, 10).Click();      
           Get_Toolbar_BtnSwitchBlock().Click();
        
            //Ajout d'une transaction(s):Vente YAHOO       
           AddSellOrder(quantityYHOO, item, securityYHOO);              
           ViewAndGenerateOrder();
            
           Get_OrderAccumulatorGrid().Find("Value",securityYHOO,10).DblClick();
            
           var nbrAccount = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Count
           
           Log.message(nbrAccount)
           Get_WinOrderDetail_BtnCancel().Click();
           if(nbrAccount>1){
                
                
                DeleteAllOrdersInAccumulator();
                Get_ModulesBar_BtnAccounts().Click();
                Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800049NA, 10).Click();      
                Get_Toolbar_BtnSwitchBlock().Click();
                //Ajout d'une transaction(s):Vente        
                AddSellOrder(quantityYHOO, item, securityYHOO);              
                //Ajout d'une transaction(s):equivalente
               
                ViewAndGenerateOrder();
              } 
            
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityYHOO, note_1);
            
            Log.message("Verifier et soumettre les ordres");  
            Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
            Get_OrderAccumulator_BtnVerify().Click(); 
            
            //verifier et soumettre les ordres 
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
            Get_WinAccumulator_BtnSubmit().Click(); 
            WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);    


            Log.PopLogFolder();
            logEtape13= Log.AppendFolder(" Ouvrir WinSCP Aller dans /home/crweb/Test_CR1571/ et consulter et valider le fichier le plus récent"); 
            Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
            SSHExecute("CommandeSSHForTCVE1408PrefNO");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
            var localDestinationFilePath=folderPath_ProjectSuiteCommonScripts +"ProjectSuiteOrdres\\Ordres\\SSH\\"
          
            //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON ) 
            var vserverFilePath="/home/crweb/Test_CR1571/SearchResultsTCVE1408PrefNO.txt" 
//          var vserverFilePath="/home/crweb/Test_CR1571/SearchResultsTCVE1408.txt" 
//          var vserverFilePathJson="/var/log/finansoft/FIXProxy.log"    
            var vserverFilePathJson="/var/log/finansoft/FIXProxy.log"        
            CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
//          CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePathJson, localDestinationFilePath);
          
          //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
            var listOfResults  = "0|";
            var arrayOfResults = listOfResults.split("|");
              
            // Déclaration de string recherchés
            var listOfStringTofind  = "2883=1|";
            var arrayOfStringTofind = listOfStringTofind.split("|"); 
          
          
            //Validation du fichier JSON
            var myFile = aqFile.OpenTextFile(localDestinationFilePath+"SearchResultsTCVE1408PrefNO.txt", aqFile.faRead, aqFile.ctANSI);                 
            while(! myFile.IsEndOfFile()){    
                line = myFile.ReadLine();
                //Split at each space character.
                 var JSONArr = line.split("\n"); 
                 Log.Message(line)      
                            for (i=0 ;i< JSONArr.length; i++){
                                if(aqObject.CompareProperty(VarToString(JSONArr[i]),cmpEqual,VarToString(arrayOfResults[i]),true,lmError)){
                                      Log.Checkpoint("Le texte "+ arrayOfStringTofind[i]+ " n est  pas  présente " + JSONArr[i] + " fois dans le fichier JSON" )
                                } 
                                else{
                                      Log.Error("Le texte "+ arrayOfStringTofind[i] +" présent " + arrayOfResults[i] + " fois dans le fichier JSON")
                                } ;
                  };
              }; 
                 
            
            
           
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         
    }
    finally {

      Terminate_CroesusProcess(); //Fermer Croesus
    }
 }

