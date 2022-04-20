//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Aucune sélection dans le pad Client 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2013
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2013_Cli_NoSelection_inClientGrid()
 {    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
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
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",349,language));// commun entre ce qui est différent de BNC
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
    if(client != "BNC" && client!= "US" && client!= "TD" && client != "CIBC"){//RJ
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
      
    }
    //Fermer la fenêtre sommation 
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
         
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }


