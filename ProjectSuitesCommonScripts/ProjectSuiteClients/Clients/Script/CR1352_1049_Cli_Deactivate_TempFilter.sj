//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Désactiver un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1049
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1049_Cli_Deactivate_TempFilter()
{
    var filtre = "500000";
    if(client == "US" ){
      var filtre = "17151.61";
    } 
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
   /* if (client == "CIBC" || client == "BNC" || client == "TD" ){
      //Scroll
      //var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
      //for (i=0; i<= 4; i++){      
      //    Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5)
      //}
    }*/
    
    Get_Toolbar_BtnQuickFilters_ContextMenu_Balance().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
    Get_WinCreateFilter_TxtValueDouble().Keys(filtre);
    Get_WinCreateFilter_BtnApply().Click();
    
    //vérification de texte
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    if(client == "US" ){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 328, language));
    } 
    else{
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 41, language));}
    
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
    Compare_SumGrid_clientNumber();
    
    //Désactiver le filtre
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
   //vérification de texte
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    if(client == "US" ){
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 328, language));
    } 
    else{
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 41, language));} // Investment Objective (Root Client) = Firm - Balanced  (Global)   Objectif de placement (Client racine) = De la firme - Equilibre  (Global)
    
     //Activer le filtre
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    Compare_SumGrid_clientNumber();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
}