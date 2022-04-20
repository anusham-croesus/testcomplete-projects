//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1174_Cli_Apply_FilterWithoutResults
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Le nom du filtre est unique par niveau d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1170
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1172_Cli_Edit_PerFiltre()
 {
   try{
        var filterName ="123";
        var value="5";
       
        Login(vServerClients, "COPERN" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
    
         //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
         
        if (client == "BNC" ){      
          Create_RootNoFilter(filterName,value) 
        }
        else{//RJ
        
          //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
          Create_PerCurrencyFilter(filterName)
        }
    
        //vérifier que le filtre  apparaît dans la fenêtre Gestion des filtres en tête de liste
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated().DblClick();
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "Description", cmpEqual, filterName);      
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filterName,100).Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit().Click();
        
        //vérifier que tous les champs sont éditables
        aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",80,language));    
        aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_TxtName(), "IsReadOnly", cmpEqual, false);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_CmbAccess(), "IsReadOnly", cmpEqual, false);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbField(), "IsReadOnly", cmpEqual, false);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbOperator(), "IsReadOnly", cmpEqual, false);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_TxtValue(), "IsReadOnly", cmpEqual, false);
                                
        Get_WinCRUFilter().Close()
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
        
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
               
     }
     catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
     finally{
     
        Delete_FilterCriterion(filterName,vServerClients)//Supprimer le filtre de BD      
     }
}

function Create_RootNoFilter(filterName,value)
{
    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
    Get_WinCRUFilter_CmbField_ItemRootNo().Click()
    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemEndingWith().Click();    
    Get_WinCRUFilter_GrpCondition_TxtValue().Keys(value);
    Get_WinCRUFilter_BtnOK().Click();  
}
