//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CROES_6794_Copy_of_configurations_simulator


/* https://jira.croesus.com/browse/TCVE-1179

Analyste d'assurance qualité: Karima M
Analyste d'automatisation: Alhassane Diallo */ 

 function TCVE_2710_GDO_3329_Validate_TheAddition_Of_PartialAndFullSwitch_InThe_Jsonfile()
 {    
     
 
        var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7;
    try{  
      
    
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2710"," Lien du Cas de test sur Jira"); 
           
           
           //Variables
           var userNameKEYNEJ  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 

           
           
           
           var account800049NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "ACCOUNT800049NA", language+client);
         
           var quantityFID227        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "QuantityFID227", language+client);
           var symbolFID227          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "SymbolFID227", language+client);
           var quantityFID228        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "QuantityFID228", language+client);
           var symbolFID228          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "SymbolFID228", language+client);
           var quantityFID228_2      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "QuantityFID227", language+client); 
           var messageConfirmation   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "MessageConfirmation", language+client);    
           var quantityTotaly        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "QuantityTotaly", language+client); 
           var quantityValue24       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "QuantityFID228_2", language+client); 
           var statutExecuted         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "Statut", language+client); 
           var messageConfirmation_2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "MessageConfirmation_2", language+client); 
           var Value1                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "Value1", language+client); 
           var Value2                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE2710", "Value2", language+client); 
          



//Étape1
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ et Sélectionner le compte 800049-NA puis Cliquer sur le bouton Switch-Blocks ");
          //Se connecter à croesus avec KEYNEJ
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();           
  
            
          //Accéder au module compte
          Log.Message("Acceder au module Compte");
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
            
          //Sélectionner les comptes 800049-NA 
          Log.Message("Sélectionner le compte "+account800049NA);
          Search_Account(account800049NA);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800049NA, 10).Click();
        
          //cliquer sur le bouton ordres en bloc 
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          
//Étape2         
          Log.PopLogFolder();
          logEtape2= Log.AppendFolder("Ajouter les ordres avec les paramètres suivants: vente FID228 avec une 50% de la quantité détenue et achat  FID227 avec une 100% de la quantité détenue puis cliquer Appercu ");
          AddSellOrderBySymbol(quantityFID228,symbolFID228)
          AddBuyOrderBySymbol(quantityFID227,symbolFID227)
          Get_WinSwitchBlock_BtnPreview().Click();
          
          //Validation du message
          aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(),"Text", cmpEqual, messageConfirmation+"\r\n"+messageConfirmation_2 );     
                 
//Étape3          
          Log.PopLogFolder();
          logEtape3= Log.AppendFolder("Cliquer sur charger la transaction puis cliquer sur Généré "); 
          Get_DlgConfirmation_BtnYes().Click();
          Delay(1000);
          //Cliquer sur Générer
          Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
          Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
          Get_WinSwitchBlock_BtnGenerate().Click(); 
          WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
          
//Étape4          
          Log.PopLogFolder();
          logEtape4= Log.AppendFolder("Retourner dans le module Comptes, Sélectionner le compte 800049-NA puis cliquer sur la fenêtre du Switch et Ajouter un ordre avec les paramétres suivants "); 
          
          //Accéder au module compte
          Log.Message("Acceder au module Compte");
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000); 
          
          
          //cliquer sur le bouton ordres en bloc 
          Get_Toolbar_BtnSwitchBlock().Click();
          WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
          
          AddSellOrderBySymbol(quantityFID228_2,symbolFID228);
          AddBuyOrderBySymbol(quantityFID227,symbolFID227);
          Get_WinSwitchBlock_BtnPreview().Click();  
          
          //Validation du message
          aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(),"Text", cmpEqual, messageConfirmation+"\r\n"+messageConfirmation_2 );    
          
//Étape5          
          Log.PopLogFolder();
          logEtape5= Log.AppendFolder("Cliquer sur Changer la transaction puis sur Aperçu puis Cliquer sur générer"); 
          Get_DlgConfirmation_BtnYes().Click();
          Get_WinSwitchBlock_BtnPreview().Click();
          Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
          Get_WinSwitchBlock_BtnGenerate().Click(); 


         
//Étape6         
          Log.PopLogFolder();
          logEtape6= Log.AppendFolder(" Vérifier puis soumettre les 2 ordres envoyés dans l'accumulateur"); 

           
          //Sélectionner l'ordre créé
          Get_OrderAccumulatorGrid().FindChild("Value", quantityTotaly, 10).Click(-1, -1, skCtrl);
          Get_OrderAccumulatorGrid().FindChild("Value", quantityValue24, 10).Click(-1, -1, skCtrl);   
          //Verifier
          Get_OrderAccumulator_BtnVerify().WaitProperty("IsEnabled",true,2000);
          Get_OrderAccumulator_BtnVerify().Click();
          
          //Soumettre
          Log.Message("Côcher la cas Inclure + Soumettre");
          Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("XamCheckEditor", "", 1).Click();
          Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("XamCheckEditor", "", 1).Click();

          Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
          Get_WinAccumulator_BtnSubmit().Click();
          
           //Valider L'ordre se dépace dans le Blotter et obtient le statut est executé
            Log.Message("Valider L'ordre se dépace dans le Blotter et obtient le statut est executé");
            var nbr = Get_OrderGrid().RecordListControl.Items.Count;
            for(var i = 0; i<nbr; i++) {
                if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbolFID228 && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == Value1){
                   
                    aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statutExecuted);
                }  
                if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == symbolFID228 && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == Value2){
                   
                    aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statutExecuted);
                }                         
            }  

                Terminate_CroesusProcess();
        
//Étape7  
          Log.PopLogFolder();
          logEtape7= Log.AppendFolder(" Ouvrir WinSCP Aller dans /home/crweb/Test_CR1571/ et consulter et valider le fichier le plus récent"); 
          Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
          SSHExecute("CommandeSSHForTCVE2710");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
          var localDestinationFilePath=folderPath_ProjectSuiteCommonScripts +"ProjectSuiteOrdres\\Ordres\\SSH\\"
          
          //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON ) 
          var vserverFilePath="/home/crweb/Test_CR1571/SearchResultsTCVE2710.txt" 
          var vserverFilePathJson="/home/crweb/Test_CR1571/JSONTCVE2710.txt"           
          CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
          CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePathJson, localDestinationFilePath);
          
          //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
          var listOfResults  = "1|2|2|1|1|";
          var arrayOfResults = listOfResults.split("|");
              
          // Déclaration de string recherchés
          var listOfStringTofind  = " dollarAmt: 24125.81|symbolCd: FID228|accountNum: 800049NA|actionCd: PARTIAL_SWITCH|actionCd: FULL_SWITCH|";
          var arrayOfStringTofind = listOfStringTofind.split("|"); 
          
          
          //Validation du fichier JSON
          var myFile = aqFile.OpenTextFile(localDestinationFilePath+"SearchResultsTCVE2710.txt", aqFile.faRead, aqFile.ctANSI);                 
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
                                      Log.Error("Le texte "+ arrayOfStringTofind[i] +" n est  pas présent " + arrayOfResults[i] + " fois dans le fichier JSON")
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

 
 
 function AddSellOrderBySymbol(quantity,symbol){
            
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        Get_WinSwitchSource_TxtQuantity().Keys(quantity)
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(symbol);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        if(Get_SubMenus().Exists){        
          Aliases.CroesusApp.subMenus.Find("Value",symbol,10).DblClick();
        }   
        Get_WinSwitchSource_btnOK().Click();
 }
 function AddBuyOrderBySymbol(quantity,symbol){
     
          
        Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchEquivalentWindow_6398");
        Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(quantity)
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Clear();
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(symbol);
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys("[Tab]");
//        if(Get_SubMenus().Exists){        
//          Aliases.CroesusApp.subMenus.Find("Value",symbol,10).DblClick();
//        }   
        Get_WinSwitchEquivalent_btnOK().Click();
 }
 
function jsonPath(localDestinationFilePath){   
   var myFile = aqFile.OpenTextFile(localDestinationFilePath+"JSONTCVE1410.txt", aqFile.faRead, aqFile.ctANSI);                 
   while(! myFile.IsEndOfFile()){    
        jsonPath = myFile.ReadLine();
        Log.Message(jsonPath)  
        return jsonPath    
   };        
}