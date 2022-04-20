//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables


/* Description : Création du filtre rapide contenant l’opérateur : excluant
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1046
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1046_Cli_Create_TempSegmentationFilter_ToolBar_btnQuickFilters()
 {
    var filtre = "A";
    
    //Login(vServerClients, userName, psw, language);
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //DefaultConfiguration
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Ajouter Segmentation
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    Get_GridHeader_ContextualMenu_AddColumn_Segmentation().Click();
          
    //Afficher la fenêtre « Ajouter un filtre » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Segmentation().Click();
        
    //Création d'un filtre
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
    Get_WinCreateFilter_DgvValue().Find("Value",filtre,1000).Click();
    Get_WinCreateFilter_BtnApply().Click();

    //Vérifier que la colonne "segmentation" exclue A   
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid    
    for (i=0; i<= count-1; i++){ 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.SegmentationDisplay, "OleValue", cmpNotEqual, filtre);       
    }  
      
    if (client == "BNC" ){
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation        
      Compare_SumGrid_clientNumber()
    }
    else{//RJ
      Compare_SumGrid_clientNumber_WithExternalClient()
    }
    
    // Cliquer sur le crayon 
    var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-35, 13);
    
    //Modification  d'un filtre
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    Get_WinCreateFilter_DgvValue().Find("Value", filtre, 1000).Click();
    Get_WinCreateFilter_BtnApply().Click();
    
    if(client == "CIBC" || client=="RJ" || client == "US" || client == "TD" ){
      Get_DlgWarning().Close();
      //Fermer le message,car le filtrer ne retourne aucune donnée 
      //Vérifier que le nombre de résultats dans le grid
      Log.Message("Jira CROES-8034, en statut open.")
      
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 0);
    }
    else{//BNC
      //Vérifier que le nombre de résultats dans le grid 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 2);
      
      //Vérifier que la colonne "segmentation" exclue A   
      var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;//Conter les résultats dans le grid    
      for (i=0; i<= count-1; i++){ 
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.SegmentationDisplay, "OleValue", cmpEqual, filtre);       
      }
    }
    
    Get_ClientsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
          
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
 }
 
