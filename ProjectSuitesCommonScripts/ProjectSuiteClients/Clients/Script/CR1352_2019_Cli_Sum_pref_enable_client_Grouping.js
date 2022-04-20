//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description : Création de critère simple par niveau d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2019
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2019_Cli_Sum_pref_enable_client_Grouping()
 {   
//Script spécifique a BNC
     try{
          Activate_Inactivate_PrefBranch(0,"PREF_ENABLE_CLIENT_GROUPING","YES",vServerClients)
          RestartServices(vServerClients)
        
          Login(vServerClients, "COPERN", psw, language);
          Get_ModulesBar_BtnClients().Click();
          
          Get_MainWindow().Maximize();
   
          //Cliquer sur Sommation  
          Get_Toolbar_BtnSum().Click();
    
          aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(), "Text", cmpEqual,GetData(filePath_Clients,"CR1352",177,language));  
          aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",178,language));
          aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClientRoots(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",179,language));
          aqObject.CheckProperty(Get_WinClientsSum_TxtAccountTotalValue(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",180,language));  
          aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfAccounts(), "Text", cmpEqual, GetData(filePath_Clients,"CR1352",181,language));
    
          //Fermer la fenêtre sommation 
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
          Get_MainWindow().SetFocus();
          Close_Croesus_SysMenu();  
        
          Activate_Inactivate_PrefBranch(0,"PREF_ENABLE_CLIENT_GROUPING","NO",vServerClients)
          //Restart
          RestartServices(vServerClients)
        
          Login(vServerClients, "COPERN", psw, language);
          Get_ModulesBar_BtnClients().Click();
   
          //Cliquer sur Sommation  
          Get_Toolbar_BtnSum().Click();
        
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(), "WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",191,language));  
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",192,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",193,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",194,language));  
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",195,language));
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",196,language));
    
          //Fermer la fenêtre sommation 
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
          Get_MainWindow().SetFocus();
          Close_Croesus_SysMenu();          
       
     }
     catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
     }
     
     finally{
       Activate_Inactivate_Pref(0,"PREF_ENABLE_CLIENT_GROUPING","YES",vServerClients) 
       //Restart
       RestartServices(vServerClients)

   }
 }
 
 




