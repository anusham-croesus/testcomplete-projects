//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
    Description : En tant que TCVE 

              je veux automatiser le Jira RPT-3606 et L'incure dans la suite de mini regression du module relation 

              pour ce Jira soit couvert pas nos mini régression quotidienne 
    Analyste d'assurance qualité : Alberto
    Analyste d'automatisation : Ayaz Sana
    
    Version de scriptage:	90.19.2020.09-36
*/

function TCVE_2783_RPT_3606()
{
    try {
          
            //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-2783","Lien de la story dans Jira");
           //Lien du cas de test dans jira
           Log.Link("https://jira.croesus.com/browse/RPT-3606","Lien vers l'anomalie");
            
            
            //Variables                
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            
            
            var relationshipNameTCVE2783=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipNameTCVE2783", language+client);
            var folderNameTCVE_2783=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "folderNameTCVE_2783", language+client);
       
            
          
            
/****************************************************Étape1****************************************************************************************/  
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1:Se connecter à croesus avec Keynej"); 
         
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
/****************************************************Étape2****************************************************************************************/  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2:Ouvrir la fenêtre info de la relation Test 1"); 
                
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            SearchRelationshipByName(relationshipNameTCVE2783);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
            var nbTries = 0;
            do {
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameTCVE2783, 10).DblClick();
            } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);            
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsEnabled", true, 5000);
/****************************************************Étape3****************************************************************************************/  
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Sélectionner l'onglet Produits & services"); 
            Get_WinDetailedInfo_TabProductsAndServices().Click();            
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsEnabled", true, 5000);
           
/****************************************************Étape4****************************************************************************************/  
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4:Sélectionner l'onglet rapport par défault"); 
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsSelected", "True", 30000);
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports_LvwReports().FindChild("WPFControlText", "Ajouter un fichier", 10).Click(); 
/****************************************************Étape5****************************************************************************************/  
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5:Ajouter un fichier externe par exemple de format PDF ensuite Cliquer sur OK pour sauvegarder les changements"); 
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnAddAReport().Click(); 
            var FolderPath=folderPath_Data +folderNameTCVE_2783;
            Get_WinParameters_TxtFileName().Keys(FolderPath);
            Get_WinParameters_BtnOK().Click();
            Get_WinDetailedInfo_BtnOK().WaitProperty("Enabled", true, 15000);
            Delay(3000);
            Get_WinDetailedInfo_BtnOK().Click(); 
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
/****************************************************Étape6****************************************************************************************/  
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Sélectionner à nouveau la relation Test 1/ Info / rapports par défaut"); 
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
            SearchRelationshipByName(relationshipNameTCVE2783);
            WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
            var nbTries = 0;
            do {
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameTCVE2783, 10).DblClick();
            } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
            
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsEnabled", true, 5000);
            Get_WinDetailedInfo_TabProductsAndServices().Click();
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
            
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsEnabled", true, 5000);
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().WaitProperty("IsSelected", "True", 30000);
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"]);
/****************************************************Étape7****************************************************************************************/  
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Enlever le document externe (mais avec la flèche qui enleve un document à la fois) / Cliquer sur OK pour sauvegarder les changements => CRASH"); 
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports_LvwReports().FindChild("WPFControlText", "Ajouter un fichier", 10).Click();
            Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAReport().Click(); 
            Get_WinDetailedInfo_BtnOK().WaitProperty("Enabled", true, 15000);
            Delay(3000);
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
            Log.Message("L'anomalie RPT-3606")
            SetAutoTimeOut();
            if(Get_DlgError().Exists) 
               Log.Error("Croesus Crash")
            else
               Log.Checkpoint("L'application ne crash pas.");
            RestoreAutoTimeOut();  


}
    catch(e) {
         
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         Terminate_CroesusProcess(); 
		         
    }
    finally {
            
           
            
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}