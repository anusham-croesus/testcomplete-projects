//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList
//USEUNIT DBA


/* Description : Appliquer la sommation sur le résultat d'une liste manuelle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2015
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2015_Cli_ApplySum_ToManualListResult()
 {     
    var type= GetData(filePath_Clients,"CR1352",155,language)
    var criterion= GetData(filePath_Clients,"CR1352",59,language)
    var fictifClient="2015FICTIF"
    var externClient="2015EXTERN"
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    try{     
        //Ajouter un client fictif
        Get_Toolbar_BtnAdd().Click();
        Get_ClientsGrid_ContextualMenu_Add_CreateFictitiousClient().Click();    
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(fictifClient);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])
       
         //Ajouter un client fictif
        Get_Toolbar_BtnAdd().Click();
        Get_ClientsGrid_ContextualMenu_Add_CreateExternalClient().Click();    
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(externClient);
        Get_WinDetailedInfo_BtnOK().Click();
        
        Search_Client("~")
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).set_IsSelected(true);
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(1).set_IsSelected(true);      
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Keys(" ");
        
        //Cliquer sur la liste pour  activer la liste manuelle
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
        
        //Vérifier que le critère est appliqué est activé  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif 
   
        //Cliquer sur Sommation  
        Get_Toolbar_BtnSum().Click(); 
        if(client == "RJ" || client == "CIBC")  
        {
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(), "WPFControlText", cmpEqual, 0);
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(), "WPFControlText", cmpEqual, 0);          
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, 0);
        }
        else {aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, 0);}
        Log.Message("CROES-7259");
        
        //Fermer la fenêtre sommation 
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();

        //Cliquer sur la liste pour  desactiver la liste manuelle
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
        
        //Vérifier que le critère est appliqué est activé  
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif 
    
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
        else if(client == "US" ){
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
          aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language))
          //else
          //aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Clients,"CR1352",356,language)); //EM :  Modifié depuis 90-07-23-RJ-CO
        }
        //Fermer la fenêtre sommation 
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();  
		
		   //Supprimer le critère par default
       Delete_DefaultClientsList(type) 
         
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
          
        Execute_SQLQuery("delete from b_client where nom='"+fictifClient+"'",vServerClients)
        Execute_SQLQuery("delete from b_client where nom='"+externClient+"'",vServerClients)
        Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD     
    }
 }

 function test123()
 {
   
  aqObject.CheckProperty(Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(), "WPFControlText", cmpEqual, 0);
 
   
 }

 
