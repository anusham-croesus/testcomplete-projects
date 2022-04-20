//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT Global_variables
//USEUNIT CR1352_1172_Cli_Edit_PerFiltre
//USEUNIT DBA

/* Description : Supprimer un filtre dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1175
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1175_Cli_Delete_FilterFromManageFilters()
{
   try {
        var filterName ="123";
        var value="5";
       
        Login(vServerClients, "COPERN" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
          
        //Création d’un filtre 
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();       
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();   
        
        var countWaitForCloseButton = 0;
        if (client == "BNC"){           
          Create_RootNoFilter(filterName,value);
          while ((++countWaitForCloseButton) <= 3 && !Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Exists)
              Delay(5000); //Christophe : Stabilisation
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        }
        else {//RJ
          Create_PerCurrencyFilter(filterName);
          while ((++countWaitForCloseButton) <= 3 && !Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Exists)
              Delay(5000); //Christophe : Stabilisation
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        }
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click(); 
        
        //YR: Version AT:Le script a été adapté , la partie qui valider le Global filtre a été commentée  
        /*Valider que pour le filtre global le bouton supprimer est grisé      
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value","Global",10).Click()
    
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);*/
        
        //Valider la suppression de filtre crée par utilisateur  
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filterName,10).Click()
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
             
        //Cliquer sur No dans le message 
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpMatches, GetData(filePath_Clients,"CR1352",86,language));       
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(2/3), Get_DlgConfirmation().get_ActualHeight()-45);
        
        //vérifier que le filtre n’a pas été supprimé 
        Check_IfFilterSavedInManageFilters(filterName)
        
         //Clique sur Supprimer dans le message 
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filterName,10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete().Click();
        // Get_DlgCroesus().Click(94, 74);
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        var numberOftries=0;  
        while ( numberOftries < 5 && Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            numberOftries++;
        } 
   //     Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
   
        //vérifier que le filtre a été supprimé 
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filterName){
             findFilter=true;             
             break;             
          }             
        } 
        if (findFilter==true){
            Log.Error("Le filtre est sur la liste ");
        }
        else{
            Log.Checkpoint("Le filtre n'est pas sur la liste ");  
        }
                        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();  
 
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName,vServerClients);//Supprimer le filtre de BD
        Terminate_CroesusProcess();
    }
}

