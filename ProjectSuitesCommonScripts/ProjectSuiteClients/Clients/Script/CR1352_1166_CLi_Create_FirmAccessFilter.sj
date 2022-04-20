//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description :Création des filtres dont le niveau d’accès est Global
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1165
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1166_Cli_Create_FirmAccessFilter()
 {
    try{
               
        Activate_Inactivate_Pref('ROOSEF',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)   
        if(client=="RJ" || client  == "US" || client == "TD" || client == "CIBC" ){
          Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients) 
          RestartServices(vServerClients)
        }
        var filtre="Filtre_Firm"
             
        Login(vServerClients,"COPERN",psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filtre);
        Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
        Get_WinCRUFilter_CmbAccess_ItemFirm().Click();     
        Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
        Get_WinCRUFilter_CmbField_ItemProducts().Click()
        Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemExcluding().Click(); 
        
        //Scroll
        Get_WinCRUFilter().Parent.Position(400, 100, Get_WinCRUFilter().Parent.Width, Get_WinCRUFilter().Parent.Height);//Christophe: Stabilisation
        var ControlWidth=Get_WinCRUFilter_GrpCondition_DgvValue().get_ActualWidth()
        var ControlHeight=Get_WinCRUFilter_GrpCondition_DgvValue().get_ActualHeight()
        for (i=1; i<=3; i++) { Get_WinCRUFilter_GrpCondition_DgvValue().Click(ControlWidth-40, ControlHeight-3)}    
        
        Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",72,language),1000).Click()
        Get_WinCRUFilter_BtnOK().Click();
               
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
         
        //*************************************************************************************************************************************************************      
        Login(vServerClients, "ROOSEF" , psw ,language);
        Get_ModulesBar_BtnClients().Click();       
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Frankelin Roosevelt (ROOSEF)");
        
        
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click()
           
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsEnabled", cmpEqual, true); 
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
   
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true);
   
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,1000).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay().Click();
               
        //La fenêtre Consulter un filtre s'affiche ou tous les champs sont en lecture seulement 
        aqObject.CheckProperty(Get_WinCRUFilter(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",69,language));    
        aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_TxtName(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpDefinition_CmbAccess(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbField(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinCRUFilter_GrpCondition_CmbOperator(), "IsReadOnly", cmpEqual, true);
        
        Get_WinCRUFilter_BtnClose().Click();
               
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
        //Les points de vérification 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtre);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
        
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(filtre,vServerClients)//Supprimer le filtre de BD   
        Activate_Inactivate_Pref('ROOSEF',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
         if(client=="RJ" || client  == "US" || client == "TD" || client == "CIBC"){
          Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)  
        }
    }
 }
 