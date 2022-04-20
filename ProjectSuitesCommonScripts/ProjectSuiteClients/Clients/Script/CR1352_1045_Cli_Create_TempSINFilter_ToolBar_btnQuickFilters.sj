//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Création du filtre rapide contenant l’opérateur : n'est pas à blanc
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1045
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1045_Cli_Create_TempSINFilter_ToolBar_btnQuickFilters()
{   
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
   
    if (client == "BNC" ){  
          //Scroll
      //var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
      //for (i=0; i<= 2; i++){      
      //    Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);
      //} 
      
      Get_Toolbar_BtnQuickFilters_ContextMenu_SIN().Click();
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsNotEmpty().Click();
      Get_WinCreateFilter_BtnApply().Click();  
    }
    if(client == "US" ){
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Name().Click();
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsNotEmpty().Click();
      Get_WinCreateFilter_BtnApply().Click(); 
    } 
    if(client != "US" && client != "BNC" ){//RJ
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Margin().Click();
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsNotEmpty().Click();
      Get_WinCreateFilter_BtnApply().Click(); 
      
      //Les points de vérification : Vérifier que dans le gris, il y a seulement des clients avec le Code de CP BD88
      var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid 
   
      for (i=0; i<= count-1; i++){ 
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Margin, "OleValue", cmpEqual, 0);
      }      
    }
    if(client == "US" ){
      Compare_SumGrid_clientNumber_WithExternalClient();
    } 
    
    //Vérifier le nombre de clients dans la grille et le comparer avec le nombre de clients dans la fenêtre sommation
   else{ Compare_SumGrid_clientNumber();}
   
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
   
}