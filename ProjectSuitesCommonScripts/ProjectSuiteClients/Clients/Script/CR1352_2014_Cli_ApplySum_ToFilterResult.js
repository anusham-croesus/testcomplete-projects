﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Appliquer la sommation sur le résultat du filtre
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2014
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2014_Cli_ApplySum_ToFilterResult()
 {    
      if(client == "US" ){
      var filtre =118247.42;}
      else{ 
      var filtre =800000;}
      Login(vServerClients, userName, psw, language);
      Get_ModulesBar_BtnClients().Click();   
      
      Get_MainWindow().Maximize(); 
       
      //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    
//      if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
//        //Scroll
//        var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight()
//        for (i=0; i<= 3; i++){      
//            Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5)                   
//        } 
//      }
      
      Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();
    
      //Création d'un filtre
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
      Get_WinCreateFilter_TxtValueDouble().Keys(filtre);
      Get_WinCreateFilter_BtnApply().Click();  
   
      //Vérifier le texte du filtre 
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
   
      
      //Cliquer sur Sommation  
      Get_Toolbar_BtnSum().Click();   
      if (client == "BNC"){ 
        aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(), "Text", cmpEqual,GetData(filePath_Clients,"CR1352",184,language));  
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",185,language));
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",186,language));
        aqObject.CheckProperty(Get_WinClientsSum_TxtAccountTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",187,language));  
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",188,language));
      }
      if (client == "US" ){
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",312,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",313,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",314,language));
  
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",354,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",355,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
      }
      if(client == "CIBC" ){ 
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",370,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",370,language));
      
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",211,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",371,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",371,language));
      } 
      if(client != "BNC" && client != "US" && client != "CIBC"){//RJ,TD
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",214,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",214,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",216,language));
  
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",215,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",215,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
      
      }
      //Fermer la fenêtre sommation 
      Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
      
      //Fermer le critère appliqué
      var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
      Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
       
      //Cliquer sur Sommation  
      Get_Toolbar_BtnSum().Click(); 
      
      if (client == "BNC"){
        aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(), "Text", cmpEqual,GetData(filePath_Clients,"CR1352",177,language));  
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",178,language));
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",179,language));
        aqObject.CheckProperty(Get_WinClientsSum_TxtAccountTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",180,language));  
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",181,language));
      }
      if(client == "US" ){
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",344,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",345,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",348,language));
      
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",347,language));// commun entre ce qui est différent de BNC
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",346,language));// commun entre ce qui est différent de BNC
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",349,language));
      }
      if(client == "TD" ){
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",339,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",340,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",341,language));
      }
      if(client == "CIBC" ){ 
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",366,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",366,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
      }
      if(client != "BNC" && client!= "US"){
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",211,language));// commun entre ce qui est différent de BNC
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));// commun entre ce qui est différent de BNC
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));// commun entre ce qui est différent de BNC
      } 
      if(client != "BNC"&& client!= "US" && client!= "TD" && client != "CIBC"){//RJ
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
        aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));      
      }
      //Fermer la fenêtre sommation 
      Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
         
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
 }