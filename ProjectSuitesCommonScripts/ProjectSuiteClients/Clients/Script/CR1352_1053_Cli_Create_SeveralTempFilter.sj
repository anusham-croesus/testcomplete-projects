//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Créer simultanément plusieurs filtres temporaires
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1053

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1053_Cli_Create_SeveralTempFilter()
 {
 try{
    var filtre = "15000";
    if(client == "US" ){
     var filtre1 = GetData(filePath_Clients, "CR1352", 318, language); } 
    else{
    var filtre1 = GetData(filePath_Clients, "CR1352", 51, language);}
    var filtre2 = "800"
    var filtre3 = "001"
    
   var nbreClientApresDesactivFiltre=GetData(filePath_Clients,"CR1352",393,language)
   var nbreClientRacineApresDesactivFiltre=GetData(filePath_Clients,"CR1352",394,language)
   
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //CRÉATION D’UN FILTRE SOLDE
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
//    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
//      //Scroll
//      var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
//      for (i=0; i<= 4; i++){      
//        Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);                
//      } 
//    }
    
    Get_Toolbar_BtnQuickFilters_ContextMenu_Balance().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
    Get_WinCreateFilter_TxtValueDouble().Keys(filtre);
    Get_WinCreateFilter_BtnApply().Click();        
    
    //vérification de texte
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 54, language));  
    
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
    Compare_SumGrid_clientNumber();  
    
    //CRÉATION DU FILTRE SEXE 
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
        
//    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
//      //Scroll
//      for (i=0; i<= 2; i++){      
//        Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);
//      } 
//    }
    
    Get_Toolbar_BtnQuickFilters_ContextMenu_Gender().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    Get_WinCreateFilter_DgvValue().Find("Value", filtre1, 1000).Click();
    Get_WinCreateFilter_BtnApply().Click();        
    
    //vérification de texte
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true);
    if(client == "US" ){
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 334, language));  }
    else{
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 52, language)); } 
    
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
    Compare_SumGrid_clientNumber();   
    
    //CRÉATION DU FILTRE NO CLIENT
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filtre2);
    Get_WinCreateFilter_BtnApply().Click();
    
    
    //Les points de vérification : le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 55, language));
    
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
    Compare_SumGrid_clientNumber();
    
    if (client == "BNC" ){
    //CRÉATION DU FILTRE NAS
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters  
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click(); 
      
//    //Scroll
//    var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
//    for (i=0; i<= 2; i++){      
//      Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);                 
//    }
      
    Get_Toolbar_BtnQuickFilters_ContextMenu_SIN().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filtre3);
    Get_WinCreateFilter_BtnApply().Click(); 
    
    //Les points de vérification : le texte de filtre
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(4), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(4).DataContext, "FilterDescription", cmpEqual, GetData(filePath_Clients, "CR1352", 53, language));
    
    //Vérifier le nombre de clients dans la grille et le compare avec le nombre de clients dans la fenêtre sommation    
    Compare_SumGrid_clientNumber();
    }
    
    if (client == "BNC" ){
    //Vérifier  le nombre filtres affichés  
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 4);
    }
    else{//RJ
    //Vérifier  le nombre filtres affichés  
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 3);
    }
    /*Désactiver tous les filtres temporaires
     Cliquer sur Sommation
     Résultat:Tous les clients s'affichent
      */
      
      //Désactiver tous les filtres temporaires
       
        
      for(i=1; i<=4; i++)
   {

   Get_RelationshipsClientsAccountsGrid_BtnFilter(i).Click();
   }
    //Cliquer sur sommation
       Get_Toolbar_BtnSum().Click();
       //Les ppints de vérifications :Tous les clients s'affichent
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, nbreClientApresDesactivFiltre);
       aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, nbreClientRacineApresDesactivFiltre);   
       Get_WinRelationshipsClientsAccountsSum_BtnClose().Click(); //Les points de vérifications
       

 }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         
   }
   finally{
   
         Terminate_CroesusProcess();
   }       
  } 
 