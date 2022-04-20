//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT CROES_8311_Account_CrashAfterSearchingByCPCode



/**
        Description : 
                  
                          1. Se connecter avec COPERN
                          2. Aller au module par exemple Compte 
                          3. Créer un filtre rapide (Devise = NOK)
                          4. Click sur l'icône [X] pour exporter le document à Excel



    Auteur : Sana Ayaz
    Anomalie:CROES-10085
    Version de scriptage:ref90-07-Co-9--V9-Be_1-co6x
*/
function CROES_10085_CrashWhenExportExcelFilWithFilterWithoutData()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //1. Se connecter avec COPERN
        Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
       
        
        var DeviseCROES_10085=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "DeviseCROES_10085", language+client);
        var NameFilterCROES_10085=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "NameFilterCROES_10085", language+client);
        var NumberTheBugCROES_10085=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "NumberTheBugCROES_10085", language+client);
        
        // 2. Aller au module par exemple Compte 
      
        Get_ModulesBar_BtnAccounts().Click();
        //3. Créer un filtre rapide (Devise = NOK)
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_Currency().Click();
          
          Get_WinCreateFilter_DgvValue().FindChild("Value", "NOK", 10).Click();
          Get_WinCreateFilter_BtnSaveAndApply().Click();
          Get_WinSaveFilter_TxtName().Keys(NameFilterCROES_10085);
          Get_WinSaveFilter_BtnOK().Click();
           var width = Get_DlgWarning().Get_Width();
           Get_DlgWarning().Click((width*(1/2)),73); 
           
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).ClickR(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).ClickR(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
           Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel().Click();
        // 4. Click sur l'icône [X] pour exporter le document à Excel
         //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
         CheckPointForCrash(NumberTheBugCROES_10085);
   
   
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); //Fermer Croesus
         Delete_FilterCriterion(NameFilterCROES_10085, vServerAccounts); //Supprimer le filtre
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
         Delete_FilterCriterion(NameFilterCROES_10085, vServerAccounts); //Supprimer le filtre
        
    }
}
