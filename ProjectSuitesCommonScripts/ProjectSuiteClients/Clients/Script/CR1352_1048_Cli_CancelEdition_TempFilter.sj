//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Annulation de la modification d'un filtre temporaire et Cas de filtre rapide qui ne retourne aucune donnée
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1048
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1052
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1048_Cli_CancelEdition_TempFilter()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
    if (client == "BNC" ){
      Get_Toolbar_BtnQuickFilters_ContextMenu_InvestmentObjectiveRootClient().Click();
    }
    else{//RJ
      Get_Toolbar_BtnQuickFilters_ContextMenu_InvestmentObjective().Click();
    }
    
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    Get_WinCreateFilter_DgvValue().Find("Value", GetData(filePath_Clients, "CR1352", 32, language), 1000).Click();
    Get_WinCreateFilter_BtnApply().Click(); 
    
    //Vérifier le texte de message
    aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",33,language));
    Get_DlgWarning().Close()
    
    Check_FilterDescription()
   
    // Cliquer sur le crayon 
    var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13);
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
    Get_WinCreateFilter_BtnCancel().Click();
    
    Check_FilterDescription()
    
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
 }
 
 function Check_FilterDescription()
 {
   if (client == "BNC" ){
      //vérification de texte du filtre
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 34, language)); 
   }
    else{//RJ
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 219, language)); // EM : Depuis LOB il n'y plus de "Global" dans la bd
   }
 }