//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Création de filtres dont le niveau d’accès est utilisateur
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1169
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1169_Cli_Create_UserAccessFilter()
 {
    try{ 
 
        var filtre="Filtre_Utilisateur"
             
        Login(vServerClients, userName,psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Create_UserAccessFilter(filtre);             
        
         //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filtre){
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
         
        //*******************************************************************************************************************************************************
        //vérifier que dans la fenêtre Gestions des filtres, Le Filtre_Utilisateur n’apparaît pas  dans le gestionnaire des filtres
        Login(vServerClients, "DARWIC" , psw ,language);
        Get_ModulesBar_BtnClients().Click();  
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Charles Darwin (DARWIC)");
        
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
          //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
        var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filtre){
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
        if(client == "RJ" || client == "CIBC"){aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, false)}
        else {aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, true);}
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsEnabled", cmpEqual, true);
         
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click(); 
        
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(filtre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 
 function Create_UserAccessFilter(filtre)
 {
    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filtre);
    Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
    Get_WinCRUFilter_CmbAccess_ItemUser().Click();     
    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
    Get_WinCRUFilter_CmbField_ItemCurrency().Click()
    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();    
    //Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true);  
    Get_WinCRUFilter_GrpCondition_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();  
    Get_WinCRUFilter_BtnOK().Click();  
 }