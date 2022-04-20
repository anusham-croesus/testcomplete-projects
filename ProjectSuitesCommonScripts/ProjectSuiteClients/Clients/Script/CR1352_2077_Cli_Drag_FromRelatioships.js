//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Maillage vers les autres modules a partir de la section Détails
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2077
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_2077_Cli_Drag_FromRelatioships()
{
    try {
        // script spécifique pour BNC
        var clientNo="800075"
        var relationshipsValue="00000"
        var relationships= GetData(filePath_Clients,"CR1352",205,language)
    
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
      
        Get_MainWindow().Maximize();
    
        //sélectionner le client
        Search_Client(clientNo);
    
        //Mailler vers le module relationshipsValue  
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).Click();   
        Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10), Get_ModulesBar_BtnClients())
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
      
        aqObject.CheckProperty(Get_ModulesBar_BtnClients(),"IsChecked",cmpEqual,true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext,"FilterDescription",cmpContains,relationshipsValue)
    
        // Fermer le filtre
        var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
    
        //sélectionner le client 
        Search_Client(clientNo);

        //Mailler vers le module comptes 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).Click();
        Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10), Get_ModulesBar_BtnAccounts())
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
    
        aqObject.CheckProperty(Get_ModulesBar_BtnAccounts(),"IsChecked",cmpEqual,true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext,"FilterDescription",cmpContains,relationshipsValue)
    
        Get_ModulesBar_BtnClients().Click();
        //Mailler vers le module Portefeuille  
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).Click();
        Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10), Get_ModulesBar_BtnPortfolio())
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
    
        aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(),"IsChecked",cmpEqual,true)
        aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton().DataContext,"TabTextHeader",cmpContains,relationshipsValue)
    
        Get_ModulesBar_BtnClients().Click();
        //Mailler vers le module Transactions  
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10).Click();
        Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",relationships,10).Find("OriginalValue",relationshipsValue,10), Get_ModulesBar_BtnTransactions())
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
    
        //Validation a été faite seulement pour être sûr qu’on a dans le module Transactions   
        aqObject.CheckProperty(Get_ModulesBar_BtnTransactions(),"IsChecked",cmpEqual,true)
             
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}