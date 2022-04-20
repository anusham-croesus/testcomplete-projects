//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1056_Cli_TempFilter_SavedAndLoaded_AfterStartup
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description : Au redémarrage, le filtre temporaire sauvegardé est chargé en conservant son état initial
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1345
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1345_Cli_TemporaryFilter_SavedAndLoaded_AfterStartup_WithInitialSate()
 {
    var temporaryFiltre = "canada"
    var permanentFiltre = "Pays_Filtre";
 
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   //Delay(200);
   
    var criterion= GetData(filePath_Clients,"CR1352",59,language)
    Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD 
   
   Delete_DefaultClientsList_InSearchCriteriaManager();//la fonction est dans CR1352_Cli_TemporaryFilter_SavedAndLoaded_AfterStartup
   
   try{
      //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Address().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Address_Country().Click();
      
       //Création d'un filtre  
      //Get_WinCreateFilter_CmbOperator().ClickItem(Get_WinCreateFilter_IndexForOperatorEqualTo());
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();
      Get_WinCreateFilter_TxtValue().Keys(temporaryFiltre);
      Get_WinCreateFilter_BtnApply().Click();  
          
      //Les points de vérification 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients,"CR1352",65,language));
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
                      
      // Cliquer sur le caryon     
      var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13);
      
      //Cliquer sur Sauvegarder et Appliquer 
      Get_WinCreateFilter_BtnSaveAndApply().Click();          
      Get_WinSaveFilter_TxtName().Keys(permanentFiltre);
      Get_WinSaveFilter_BtnOK().Click();
          
      //Les points de vérification 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, permanentFiltre);
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
   
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click()
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
   
      Get_MainWindow().SetFocus();
      Close_Croesus_SysMenu();
          
      Login(vServerClients, userName , psw ,language);
      Get_ModulesBar_BtnClients().Click();
          
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
   
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally{
   
        Delete_FilterCriterion(permanentFiltre,vServerClients);
   }       
  } 