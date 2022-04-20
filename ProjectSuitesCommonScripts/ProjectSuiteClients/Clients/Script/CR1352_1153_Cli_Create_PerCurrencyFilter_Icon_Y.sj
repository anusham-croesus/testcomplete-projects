//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Création du filtre rapide permanent a partir de 'Ajouter un filtre ...
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1153
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y()
 {
   
   var filterName ="Test1";
    
   Login(vServerClients, userName , psw ,language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   try{ 
       //Afficher la fenêtre « Ajouter un filter » en cliquant l'icone (Y) en haut a gauche   
       Get_RelationshipsClientsAccountsGrid().Click(10,10)
       Get_RelationshipsClientsAccountsGrid().Click(10,10)
       Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();   
   
       //Création du filtre
       Create_PerCurrencyFilter(filterName)
    
        //Les points de vérification 
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filterName);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
       
       //Vérifier que le filtre apparaît dans le  menu Filtres prédéfinie en tête de liste 
       Check_IfPositionOfFilter_AfterPredefinedFilters(filterName)
        
       //Vérifier que le filtre rapide est sauvegardé dans la fenêtre Gestion des filtres en respectant l’ordre alphabétique 
       Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
       Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();   
       Check_alphabeticalSort(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters())// dans Common_functions
       Check_IfFilterSavedInManageFilters(filterName)
       Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click()
          
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
   finally{
   
        Delete_FilterCriterion(filterName,vServerClients)//Supprimer le filtre de BD   
    }
 }

 function Create_PerCurrencyFilter(filterName)
 {
    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();            
    Get_WinCRUFilter_CmbField_ItemCurrency().Click()
    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    //Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true); 
    Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();   
    Get_WinCRUFilter_BtnOK().Click();
 }