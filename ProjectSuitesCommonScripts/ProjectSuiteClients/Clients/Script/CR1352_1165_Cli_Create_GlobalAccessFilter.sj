//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1174_Cli_Apply_FilterWithoutResults
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Création des filtres dont le niveau d’accès est Global
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1165
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1165_Cli_Create_GlobalAccessFilter()
 {
    try{
     if(client=="RJ" || client == "US" || client == "TD"){
      Activate_Inactivate_Pref('GP1859',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
      RestartServices(vServerClients);  
     }
        var filtre="Filtre_Global"
             
        Login(vServerClients, "GP1859",psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        if(client == "RJ"){aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - GP1859 Croesus (GP1859) -> Global");}
        else aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - GP1859 Croesus (GP1859) -> Global");
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
        
        if (client == "BNC" ){       
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filtre);
          Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
          Get_WinCRUFilter_CmbAccess_ItemGlobal().Click();     
          Get_WinCRUFilter_GrpCondition_CmbField().DropDown();                   
          Get_WinCRUFilter_CmbField_ItemInvestmentObjectiveRootClient().Click()
          Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemIsEmpty().Click(); 
          Get_WinCRUFilter_BtnOK().Click();
        }
        else{//RJ
        
          //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filtre);
          Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
          Get_WinCRUFilter_CmbAccess_ItemGlobal().Click(); 
          Get_WinCRUFilter_GrpCondition_CmbField().DropDown(); 
          if(client == "US" ){
          Get_WinCRUFilter_CmbField_ItemCurrency().Click();    
          }
          else{ 
          Get_WinCRUFilter_CmbField_ItemLanguage().Click();}                  
          Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
          if (client == "US" ){
            Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
            Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value",GetData(filePath_Clients,"CR1352",325,language),10).Click()} 
          else{
          Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
          Get_WinCRUFilter_GrpCondition_DgvValue().SelectAll()}
          
          
          Get_WinCRUFilter_BtnOK().Click();
        }
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click(); 
        if(client=="RJ"){
          Get_DlgWarning().Close();//Fermer le message,car le filtrer ne retourne aucune donnée 
        }
        
        //Les points de vérification 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtre);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 
            
        Login(vServerClients, "COPERN" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
        
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,1000).Click();
           
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
        if(client=="RJ" || client == "CIBC" || client == "TD"){
          Get_DlgWarning().Close();//Fermer le message,car le filtrer ne retourne aucune donnée 
        }
        
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
        if(client=="RJ" || client == "US" || client == "TD"  || client == "CIBC" ){
          Activate_Inactivate_Pref('GP1859',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)  
        }
    }
 }
 

