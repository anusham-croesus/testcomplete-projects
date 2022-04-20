//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
**** CE CAS DE TEST DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR CIBC
		 
     Correspond au Jira Croes-9830
     lien dans TestLink: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6820"
   
     Se loguer avec l'utilisateur Dycksan     
     Dans le module Relations, faire un filtre sur "Total value >1000000".               
     Sélectionner 40 relations et mailler dans le module Portefeuille, répéter 4 fois et détecter un crash		
     
     Analyste Automatisation : Amine A.
 */
 
function Performance_CROES_6820(){
  
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6820","Lien du Cas de test sur Testlink");
      try {      
            var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
            var nbTries = 4;
            
            var filterDescription = "Total Value";
            var filterTotalValue  = "100000";
            
            var userNameDycksan = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DYCKSAN", "username");
            var passwordDycksan = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DYCKSAN", "psw");
                    
            // Se connecter à croesus avec 'DYCKSAN'          
            Login(vServerPerformance, userNameDycksan, passwordDycksan, language);

            // Attend le module relations présent et actif
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"], waitTimeShort);
            Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnRelationships().Click();
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
            Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);

            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

            // Dans le module Relations, faire un filtre sur "Total value > 1000000".
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            WaitObject(Get_CroesusApp(), "Uid", "FinancialInstrumentSelector_c84d", 3000);
            Get_SubMenus_ByDescription(filterDescription).Click(); 
            Get_WinCreateFilter_CmbOperator().DropDown();     
            Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();            
            Get_WinCreateFilter_TxtValueDouble().Keys(filterTotalValue);
            Get_WinCreateFilter_BtnApply().Click();
        
            // Sélectionner 40 relations, mailler dans Portefeuille, 4 fois et attendre un crush
            for (i = 1; i <= nbTries; i++){
                  SelectRelationshipAndDragAndCheckForCrash(i);       
            }
            }
            
      catch (e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));}
      finally {
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            //Fermer le processus Croesus
            Terminate_CroesusProcess();
          }
}

function SelectRelationshipAndDragAndCheckForCrash(j){
  
           var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);  
          
          Get_RelationshipsClientsAccountsGrid().Click(100,60);
          Sys.Desktop.KeyDown(0x10);
          for(i = 0; i< 20; i++) Get_RelationshipsClientsAccountsGrid().Click(1833,580);
          Get_RelationshipsClientsAccountsGrid().Click(100,450);
          Sys.Desktop.KeyUp(0x10);
          for(i = 0; i< 20; i++) Get_RelationshipsClientsAccountsGrid().Click(1833,580);
                      
          //Mailler la selection dans Portefeuille
          Get_MenuBar_Modules().DblClick();
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().DblClick();
          WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["CFMenuItem_edd3", true], waitTimeShort); 
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
//          Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);         
         
          Delay(5000);
          Log.Message("le crash doit se produire ici , Maillage.......... : "+ j);
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
          Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);
   
}

