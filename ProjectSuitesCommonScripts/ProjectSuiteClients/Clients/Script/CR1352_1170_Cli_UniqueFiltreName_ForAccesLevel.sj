//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Le nom du filtre est unique par niveau d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1170
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1170_Cli_UniqueFiltreName_ForAccesLevel()
 {
   try{
       var filterName ="Test1";
       var userLevel=GetData(filePath_Clients,"CR1352",76,language);
       var branchLevel=GetData(filePath_Clients,"CR1352",77,language);
       
       Login(vServerClients, "COPERN" , psw ,language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
    
         //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();     
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemCurrency().Click()
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();    
        //Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true); 
        Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();  
        Get_WinCRUFilter_BtnOK().Click();  
    
       //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if (Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description() == filterName && VarToStr(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()) == userLevel){
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
              
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
        
                
        //Ajouter un autre filtre qui porte le même nom  TEST1 et avec le même niveau d'accès Utilisateur 
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
        Get_WinCRUFilter_CmbAccess_ItemUser().Click();     
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemCurrency().Click()
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();    
        //Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true); 
        Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();  
        Get_WinCRUFilter_BtnOK().Click(); 
        Log.Message("Le numéro de l'anomalie trouvé pour CX : CROES-7951")
        //vérifier que le message d'erreur s'affiche  
        Log.Message("CROES-4495")
        
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpMatches, GetData(filePath_Clients,"CR1352",75,language)); //EM: Le datapool a été modifié selon le Jira CROES-4495 
        Get_DlgWarning().Close();
        
        Get_WinCRUFilter_BtnCancel().Click()
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
        
        
        //Ajouter un autre filtre qui porte le même nom  TEST1 et avec niveau  d'accès Succursale 
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
        Get_WinCRUFilter_CmbAccess_ItemBranch().Click();     
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemCurrency().Click()
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemAmong().Click();    
        //Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true);
        Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();    
        Get_WinCRUFilter_BtnOK().Click(); 
        
         //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if (Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description() == filterName && VarToStr(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_PartyLevelName()) == branchLevel){
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
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();   
        
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
 