//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Création du filtre permanent a partir du filtre temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1164
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1164_Cli_Create_PerNoCLientFilter_FromTemFilter()
 {
    try{
        var temporaryFiltre ="8002";
        var permanentFiltre ="No_client";
    
        Login(vServerClients, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
        Get_WinCreateFilter_TxtValue().Keys(temporaryFiltre);
        Get_WinCreateFilter_BtnSaveAndApply().Click();
    
        Get_WinSaveFilter_TxtName().Keys(permanentFiltre);
        Get_WinSaveFilter_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SaveQuickFilterWindow_151d");  
        
               
        //Vérifier que le filtre rapide est sauvegardé dans la fenêtre Gestion des filtres en respectant l’ordre alphabétique 
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();   
        Check_alphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters())// dans Common_functions
        Check_IfFilterSavedInManageFilters(permanentFiltre)
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click()
          
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(permanentFiltre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 
 
 function test(){
 
 var temporaryFiltre ="8002";
        var permanentFiltre ="No_client";
    
   Delete_FilterCriterion(permanentFiltre,vServerClients)//Supprimer le filtre de BD
 }
 

 