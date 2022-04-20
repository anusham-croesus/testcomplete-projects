//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Paramétrage des positions bloquées et Débloquer des positions bloquées
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2487
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2488
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2487_Parameterize_Of_BlockedPositions()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var ordersDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersDescription_2494", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account);         
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10),  Get_ModulesBar_BtnPortfolio()); 
        
        var arrayOfpositionsDesc=new Array();
        
        //Sélectionner 3 positions 
        for(var i=1; i <=3; i++){
          Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true)
          //Valider que les positions ne sont pas bloquées   
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "IsBlocked", cmpEqual,false);
          arrayOfpositionsDesc[i-1]=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription
        } 
        
        Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(arrayOfpositionsDesc[1]),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Validation des changements 
          for(var i=1; i <=3; i++){
          //Valider que les positions sont bloquées   
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "IsBlocked", cmpEqual,true);
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "SecurityDescription", cmpEqual,arrayOfpositionsDesc[i-1]);         
        }
        
        //******************************************************* La couverture du cas de test Croes-2488 ***************************************************************************
        //Remettre les données à l’état initial  
        Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(arrayOfpositionsDesc[1]),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        //Validation des changements 
        for(var i=1; i <=3; i++){
          //Valider que les positions ne sont pas bloquées   
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "IsBlocked", cmpEqual,false);
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "SecurityDescription", cmpEqual,arrayOfpositionsDesc[i-1]);         
        }
                     
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account);         
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", account, 10),  Get_ModulesBar_BtnPortfolio()); 
        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).Keys("^a");
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).ClickR();        
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
       
        Close_Croesus_MenuBar();
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }
 
 
