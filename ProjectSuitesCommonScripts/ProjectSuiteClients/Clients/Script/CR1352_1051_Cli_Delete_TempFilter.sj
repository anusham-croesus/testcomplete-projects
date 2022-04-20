//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables

/* Description : Supprimer un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1051
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1051_Cli_Delete_TempFilter()
{
    var filtre = "6";
   
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
    
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filtre);
    Get_WinCreateFilter_BtnApply().Click();
    
    //Les points de vérification : le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 48, language));
    
    //Vérifier que la colonne "segmentation" exclue A   
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid    
    for (i=0; i<= count-1; i++){ 
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.ClientNumber, "OleValue", cmpContains, filtre);       
    }
    
    //Vérifier le nombre de clients dans la grille et le comparer avec le nombre de clients dans la fenêtre sommation
    Compare_SumGrid_clientNumber();
    
    // Cliquer sur x
    Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
      
    if (client == "BNC" ){
      //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation
      Compare_SumGrid_clientNumber();
    }
    else{//RJ
      Compare_SumGrid_clientNumber_WithExternalClient();
    }
         
    Get_MainWindow().SetFocus();
    Close_Croesus_AltQ();
}