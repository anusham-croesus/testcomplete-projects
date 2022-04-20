//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Un filtre rapide temporaire peut être modifié en filtre permanant  
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1039
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter()
 {
    var temporaryFiltre ="BD88";
    var permanentFiltre ="TestCodeCp";
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_IACode().Click();
    
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
    Get_WinCreateFilter_TxtValue().Keys(temporaryFiltre);
    Get_WinCreateFilter_BtnApply().Click();      
    
    // Cliquer sur le crayon 
    var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13)
    
    //Cliquer sur Sauvegarder et Appliquer 
    Get_WinCreateFilter_BtnSaveAndApply().Click();  
    
    try{      
        Get_WinSaveFilter_TxtName().Keys(permanentFiltre);
        Get_WinSaveFilter_BtnOK().Click();
        
        //Vérifier que le filtre apparait dans la grille portant  le nom ( TestCodeCp) 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, permanentFiltre); 
        
        //Vérifier que le filtre apparaît dans le  menu Filtres prédéfinie en tête de liste 
        Check_IfPositionOfFilter_AfterPredefinedFilters(permanentFiltre)
        
       //Vérifier que le filtre rapide est sauvegardé dans la fenêtre Gestion des filtres en respectant l’ordre alphabétique 
       Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
       Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();   
       Check_alphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters())// dans Common_functions
       Check_IfFilterSavedInManageFilters(permanentFiltre)
       Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click()
        
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();
    }
    
    finally{
   
            Delete_FilterCriterion(permanentFiltre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 
 
function Check_IfPositionOfFilter_AfterPredefinedFilters(filter)
{
    //Vérifier que le filtre apparaît dans le  menu Filtres prédéfinie en tête de liste 
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    var count = Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Count;//Conter les résultats 
   
    for (i=0; i<= count-1; i++){ 
      if(Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Item(i).Get_Tag()==GetData(filePath_Clients,"CR1352",21,language)){
         aqObject.CheckProperty(Get_Toolbar_BtnQuickFilters_ContextMenu().Items.Item(i+1), "WPFControlText", cmpEqual, filter)             
      }          
    } 
 
}

function Check_IfFilterSavedInManageFilters(filter)
{             
   //Vérifier que Le filtre est sur la liste de filtres  
   var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
   var findFilter=false;
    for (i=0; i<= count-1; i++){ 
      if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filter){
         findFilter=true;             
         break;             
      }             
    } 
    if (findFilter==true){
        Log.Checkpoint("Le filtre est sur la liste ");
    }
    else{
        Log.Error("Le filtre n'est pas sur la liste ");  
    }        
} 

function test()
{
    Check_alphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters())
}
