//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description ::Mailler des clients vers le module clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2018
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2018_Cli_ApplySum_AfterDragging()
 {
    //Delete_FilterCriterion(GetData(filePath_Clients,"CR1352",59,language),vServerClients)//Supprimer le filtre de BD  
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click(); 
    
    Get_MainWindow().Maximize();
      
    //Sélectionner 3 clients 
    for(var i=0; i <=2; i++){
          Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
    }  
 
    //Mailler les clients sélectionnés vers le module client    
    Get_MenuBar_Modules().Click()
    Get_MenuBar_Modules_Clients().Click()
    Get_MenuBar_Modules_Clients_DragSelection().Click()
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Cliquer sur Sommation  
    Get_Toolbar_BtnSum().Click(); 
    
        if(client == "RJ" || client == "CIBC")  
        {
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, 3);
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual, 0);
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, 3);
          
        }    
        else {aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, "3");}
    
    //Fermer la fenêtre sommation 
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    

    //Désactiver le filtre de chaînage en cliquant sur le filtre
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
       
    //Cliquer sur Sommation  
    Get_Toolbar_BtnSum().Click(); 
     
    if (client == "BNC"){
      aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(), "Text", cmpEqual,GetData(filePath_Clients,"CR1352",177,language));  
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",178,language));
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",179,language));
      aqObject.CheckProperty(Get_WinClientsSum_TxtAccountTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",180,language));  
      aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",181,language));
    } 
     else if (client == "TD"){
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",339,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",340,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",211,language));
  
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",341,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",341,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
         } 
     else if( client == "US" ){
      
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",344,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",345,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",347,language));
  
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",346,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",348,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",349,language));
     }
     else if(client == "CIBC" ){ 
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",366,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",366,language));
          
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",211,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
        } 
    else{//RJ
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",209,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",211,language));
  
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",210,language));
      aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language));
      //else
      //aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",211,language)); //EM :  Modifié depuis 90-07-23-RJ-CO    
    }   
    
    //Fermer la fenêtre sommation 
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
       
    Close_Croesus_MenuBar();
 }