//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1056_Cli_TempFilter_SavedAndLoaded_AfterStartup
//USEUNIT Global_variables

/* Description : Au démarrage de croesus, le filtre temporaire n'est pas chargé
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1055
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1055_Cli_TempFilter_IsNotLoaded_AfterStartup()
{  
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    var criterion= GetData(filePath_Clients,"CR1352",59,language)
    Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD   
    
    Delete_DefaultClientsList_InSearchCriteriaManager();//la fonction est dans CR1352_Cli_TemporaryFilter_SavedAndLoaded_AfterStartup
    
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Language().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    Get_WinCreateFilter_DgvValue().Find("Value", GetData(filePath_Clients, "CR1352", 60, language), 1000).Click();
    Get_WinCreateFilter_BtnApply().Click();
    
    //Les points de vérification: le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 61, language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    //Vérifier  le nombre filtres affichés
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 0);
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltQ();
}  
    
  


