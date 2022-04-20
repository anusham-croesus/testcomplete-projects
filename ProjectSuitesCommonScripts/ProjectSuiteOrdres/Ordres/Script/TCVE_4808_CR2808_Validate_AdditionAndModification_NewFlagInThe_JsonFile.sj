//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2456_FundReport
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CROES_6794_Copy_of_configurations_simulator



/*Description : Le but de ce cas est de Valider l'ajout et la modification de nouveau flag dans le fichier json.

 
    Analyste d'assurance qualité: Karima Mo.
    Analyste d'automatisation: Alhassane Diallo.
    ref 90.24.2021.04-13 */  
 
 function TCVE_4808_CR2808_Validate_AdditionAndModification_NewFlag_InThe_JsonFile()
 {             
    try{  

          
                  
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-4706","Lien de la story dans Jira", "TCVE-4706");
           
           Log.PopLogFolder();
           logEtape0 = Log.AppendFolder("Étape 0: Pre_condition du cas de test"); 
           
           //Activation des prefs
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_PRO_ACCOUNT_NUMBER_FORMAT","^.{8}A",vServerOrders);
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_LEGAL_ENTITY_IDENTIFIER","549300EM9IELBMKYHT27",vServerOrders);
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_ROUTING_ARRANGEMENT_INDICATOR","YES",vServerOrders);
           RestartServices(vServerOrders);
           SSHExecute("CommandeSSHForCROES6795");
          
           
    
           //Declaration des Variables
           var userNameKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
                    
           var account800077RE        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800077RE", language+client);
           var account800259NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800259NA", language+client);
           var account800251GT        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800251GT", language+client);
           var account800263FS        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800263FS", language+client);
           var account800031JW        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800031JW", language+client);
           var account800063OB        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800063OB", language+client);
           var account800049NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800049NA", language+client);
           var account800007FS        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800007FS", language+client);
           var account800007NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800007NA", language+client);
           var account800008OB        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800008OB", language+client);
           var account800008NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800008NA", language+client);
           var account800041NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800041NA", language+client);
           var account800042NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800042NA", language+client);
           var account800046NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "ACCOUNT_800046NA", language+client);
           
           
           
                                      
           var quantityDIS            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_DIS", language+client);
           var quantityRON            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_RON", language+client);
           var quantityAAPL           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_AAPL", language+client);
           var quantityBMO            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_BMO", language+client);
           var quantitySLF            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_SLF", language+client);
           var quantityMSFT           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_MSFT", language+client);
           var quantityTD             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_TD", language+client);
           var quantityYHOO           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_YHOO", language+client);
           
           var securityDIS            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_DIS", language+client);
           var securityRON            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_RON", language+client);
           var securityAAPL           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_AAPL", language+client);
           var securityBMO            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_BMO", language+client);
           var securitySLF            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_SLF", language+client);
           var securityMSFT           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_MSFT", language+client);
           var securitySLF            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_SLF", language+client);
           var bourseSLF              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "BOURSE_SLF", language+client);
           var securityYHOO           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_YHOO", language+client);
           var securityTD             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_TD", language+client);
           var note_1                 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "NOTE", language+client);
           var item                   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
            
           var securityLB             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_LB", language+client);
           var securityRCI            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_RCI", language+client);
           var quantityLB             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_LB", language+client);
           var quantityRCI            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_RCI", language+client); 
           var securityRY             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "SECURITY_RY", language+client);
           var quantityRY             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "TCVE_4808", "QUANTITY_RY", language+client); 
           
           //Se connecter à croesus avec Keynej
           Log.PopLogFolder();
           logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej"); 
           Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language); 
             
            
           Log.PopLogFolder();
           logEtape2 = Log.AppendFolder("Étape 2: Selectionner le compte 800077-RE, puis Ajouter un ordre de vente et ordre d'achat et enfin gener les ordres"); 
           
                 
           //Valider que Accamulator est vide 
           Log.Message("Valider que Accamulator est vide");
           Get_ModulesBar_BtnOrders().Click();
           DeleteAllOrdersInAccumulator();
        
            //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner le compte 800077-RE
            Log.Message("Selectionner le compte 800077-RE");
            SearchAccount(account800077RE);  
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800077RE, 10).Click();      
            Get_Toolbar_BtnSwitchBlock().Click();
        
            //Ajout d'une transaction(s):Vente        
            AddSellOrder(quantityDIS, item, securityDIS,securityDIS);              
            //Ajout d'une transaction(s):equivalente
            AddEquivalentOrder(quantityRON, securityRON);
            //Voir et generer les ordres
            ViewAndGenerateOrder(); 
            
            
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Selectionner les deux ordres leur ajouter comme notes : ??A;S(2507);F(100,20), puisles verifier et les soumettre ; "); 
            
            Get_OrderAccumulatorGrid().Find("Value",securityRON,10).DblClick();
            
            var nbrAccount = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Count
           
             Log.message(nbrAccount)
             Get_WinOrderDetail_BtnCancel().Click();
             if(nbrAccount>1){
                
                
                DeleteAllOrdersInAccumulator();
                Get_ModulesBar_BtnAccounts().Click();
                Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800077RE, 10).Click();      
                Get_Toolbar_BtnSwitchBlock().Click();
                //Ajout d'une transaction(s):Vente        
                AddSellOrder(quantityDIS, item, securityDIS);              
                //Ajout d'une transaction(s):equivalente
                AddEquivalentOrder(quantityRON, securityRON);
                //Voir et generer les ordres
                ViewAndGenerateOrder();
             }
            
            
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityDIS, note_1);
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityRON, note_1);
            //verifier et soumettre les ordres 
            VerifyAndSubmitOrders();
            
            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Sélectionner le compte pro 800259-NA puis cliquer sur l'icône Ordres multiples lui Ajouter un ordre de vente et un ordre d'achat et enfin le  générer"); 
          
             //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner le compte 800259-NA
            Log.Message("Selectionner le compte 800259-NA");
            SearchAccount(account800259NA);  
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800259NA, 10).Click();    
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Ajout d'une transaction(s):Vente        
            AddSellOrder(quantityAAPL, item, securityAAPL,securityAAPL);              
            //Ajout d'une transaction(s):equivalente
            AddEquivalentOrder(quantityBMO, securityBMO);
            //Voir et generer les ordres
            ViewAndGenerateOrder(); 
            
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Selectionner les deux ordres leur ajouter comme notes : ??A;S(2507);F(100,20), puisles verifier et les soumettre ; "); 
          
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityAAPL, note_1);
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityBMO, note_1);
            //verifier et soumettre les ordres 
            VerifyAndSubmitOrders();
            
            
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Selectionner les comptes 800007-FS, 800007-NA, 800008-NA et 800008-OB"); 
          
            //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner les comptes 800007-FS, 800007-NA, 800008-NA et 800008-OB
            Log.Message("Selectionner les comptes 800251-GT, 800263-FS, 800031-JW, et 800063-OB");
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            SearchAccount(account800007FS);  
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800007FS, 10).Click(-1, -1, skCtrl); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800007NA, 10).Click(-1, -1, skCtrl); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800008OB, 10).Click(-1, -1, skCtrl); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800008NA, 10).Click(-1, -1, skCtrl);;    
            Get_Toolbar_BtnSwitchBlock().Click();
        
            //Ajout d'une transaction(s):Vente        
            AddSellOrder(quantitySLF, item, securitySLF,bourseSLF);              
            //Ajout d'une transaction(s):equivalente
            AddEquivalentOrder(quantityTD, securityTD);
            //Voir et generer les ordres
            ViewAndGenerateOrder(); 
            
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Selectionner les deux ordres leur ajouter comme notes : ??A;S(2507);F(100,20), puisles verifier et les soumettre ; "); 
          
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securitySLF, note_1);
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityTD, note_1);
            //verifier et soumettre les ordres 
            VerifyAndSubmitOrders();
            
            
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11: Selectionner les comptes 800251-GT, 800263-FS, 800031-JW et 800063-OB"); 
          
            //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner le compte 800077-RE
            Log.Message("Selectionner les comptes 800251-GT, 800263-FS, 800031-JW et 800063-OB");
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            SearchAccount(account800251GT);  
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800251GT, 10).Click(-1, -1, skCtrl); 
            SearchAccount(account800263FS);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800263FS, 10).Click(-1, -1, skCtrl); 
            SearchAccount(account800031JW);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800031JW, 10).Click(-1, -1, skCtrl); 
            SearchAccount(account800063OB);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800063OB, 10).Click(-1, -1, skCtrl);;    
            Get_Toolbar_BtnSwitchBlock().Click();
        
            //Ajout d'une transaction(s):Vente        
            AddSellOrder(quantityMSFT, item, securityMSFT, securityMSFT); 
            //Ajout d'une transaction(s):equivalente
            AddEquivalentOrder(quantityRY, securityRY);             
            //Voir et generer les ordres
            ViewAndGenerateOrder(); 
            
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12: Selectionner l ordre lui ajouter comme notes : ??A;S(2507);F(100,20), puis le verifier et le soumettre ; "); 
          
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityMSFT, note_1);
             //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityRY, note_1);

            //verifier et soumettre les ordres 
            VerifyAndSubmitOrders();

            
            Log.PopLogFolder();
            logEtape13 = Log.AppendFolder("Étape 13: Selectionner les comptes 800032-NA, 800035-NA,  et 800036-NA"); 
          
            
            //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner les comptes 800032-NA, 800035-NA,  et 800036-NA
            Log.Message("Selectionner les comptes 800032-NA, 800035-NA,  et 800036-NA");
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            SearchAccount(account800041NA);  
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800041NA, 10).Click(-1, -1, skCtrl); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800042NA, 10).Click(-1, -1, skCtrl); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800046NA, 10).Click(-1, -1, skCtrl);
            
            Get_Toolbar_BtnSwitchBlock().Click();
        
            //Ajout d'une transaction(s):Vente        
            AddSellOrder(quantityLB, item, securityLB, securityLB, securityLB);              
            //Ajout d'une transaction(s):equivalente
            AddEquivalentOrder(quantityRCI, securityRCI);
            //Voir et generer les ordres
            ViewAndGenerateOrder(); 
            
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityLB, note_1);
            //Ajout de la note dans l'ordre
            AddNote_InThe_Order(securityRCI, note_1);
            //verifier et soumettre l ordres 
            VerifyAndSubmitOrders();
           
           
          Log.PopLogFolder();
          logEtape14= Log.AppendFolder("Étape 14: Ouvrir WinSCP Aller dans /home/crweb/Test_CR1571/ et consulter et valider le fichier le plus récent"); 
          Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
          SSHExecute("CommandeSSHForTCVE1408");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
          var localDestinationFilePath=folderPath_ProjectSuiteCommonScripts +"ProjectSuiteOrdres\\Ordres\\SSH\\"
          
          //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON )  
          var vserverFilePath="/home/crweb/Test_CR1571/SearchResultsTCVE1408.txt"     
          var vserverFilePathJson="/var/log/finansoft/FIXProxy.log"        
          CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
          
          //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
          var listOfResults  = "10|10|12|2|4|2|2|2|";
          var arrayOfResults = listOfResults.split("|");
              
          // Déclaration de string recherchés
          var listOfStringTofind  = "2883=1|8028=549300EM9IELBMKYHT27|6750=CL|8025=800077-RE|6750=NC|8025=800259-NA|6750=BU|6750=MC|";
          var arrayOfStringTofind = listOfStringTofind.split("|"); 
          
          
          //Validation du fichier JSON
          var myFile = aqFile.OpenTextFile(localDestinationFilePath+"SearchResultsTCVE1408.txt", aqFile.faRead, aqFile.ctANSI);                 
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
 
 function test(){
     
 
 
 
 }

//fonction qui permet d'ajouter un ordres de vente
function AddSellOrder(quantity, item, security,bourse) {    
    
Get_WinSwitchSource
          Log.Message("Ajout d'une transaction(s):Vente" );       
          Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
          if(!Get_WinSwitchSource().Exists){
            Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();  
          }
          Get_WinSwitchSource_TxtQuantity().Keys(quantity);
          Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
          Aliases.CroesusApp.subMenus.Find("WPFControlText",item,10).Click();
         
          Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
          Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(security);
          Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]"); 
          SetAutoTimeOut(); 
          if(Get_SubMenus().Exists){       
             Aliases.CroesusApp.subMenus.Find("Value",bourse,10).DblClick();   
           } 
          RestoreAutoTimeOut();     
          Get_WinSwitchSource_btnOK().Click();             
 } 


//fonction qui permet d'ajouter l'ordre d'achat equivalent
function AddEquivalentOrder(quantity, security) {    
    
         
         Log.Message("Ajout d'une transaction(s):equivalente" );
         Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
         Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(quantity)
         Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(security);
          
         Get_WinSwitchEquivalent_BtnQuickSearchListPicker().Click();
         if(Get_SubMenus().Exists){       
             Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();   
         } 
        
         Get_WinSwitchEquivalent_btnOK().Click();
              
 } 

//Fonction qui permets de voir et degenerer les ordres
function ViewAndGenerateOrder(){
    
        Log.Message(" Voir et generer les ordres");
        Get_WinSwitchBlock_BtnPreview().Click();
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
        Get_WinSwitchBlock_BtnGenerate().Click();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();
}


//Fonction qui permets d'ajouter la note dans l'ordre
function AddNote_InThe_Order(securitySymbol, note){
    
        
        Log.Message("Ajouter une note dans l'ordre");
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        Get_WinOrderDetail_TabNotes().Click();
        Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Clear();
        Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Keys(note)
        Get_WinOrderDetail_BtnSave().Click();

}

//fonction qui permets de verifier et de soumettre plusieur ordres les ordres  
function VerifyAndSubmitOrders(){
     
     Log.message("Verifier et soumettre les ordres");  
     Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
     Get_OrderAccumulator_BtnVerify().Click();
 
     Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
     Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Find("ClrClassName","XamCheckEditor",10).Click();
     Get_WinAccumulator_BtnSubmit().Click(); 
     WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);       
}
 
//fonction qui permets de verifier et de soumettre un seul ordres 
function VerifyAndSubmitOrder(){
     
     Log.message("Verifier et soumettre les ordres");  
     Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
     Get_OrderAccumulator_BtnVerify().Click();
 
     Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
     Get_WinAccumulator_BtnSubmit().Click(); 
     WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);       
}
 
//fonction qui permets de supprimer les ordres dans l'accumulateur   
function DeleteAllOrdersInAccumulator()
{   
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){
    
//       for (var i = 0; i < count; i++){
//          Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
//       } 
       
      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }   
}

function test22(){
//    Aliases.CroesusApp.winOrderDetail.WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).ChildCount
//Aliases.CroesusApp.winOrderDetail.WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Count
 var x = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1).Items.Count
 Log.message(x)
 
 
}