//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Critères de recherche sur des positions bloquées
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2489
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2489_SearchCriteria_For_LockedPositions()
 {             
    try{      
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var ordersDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersDescription_2494", language+client);
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800056FS", language+client);
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800049NA", language+client);
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800245GT", language+client);
        var criterion=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Criterion_2489", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        
        var arrayOfAccountsNo= new Array(account1,account2,account3)
        //Sélectionner 3 accounts
        SelectAccounts(arrayOfAccountsNo)
              
        //Mailler les accounts sélectionnés ver le module client    
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
        //Wait for grid 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
                
        //Sélectionner les positions       
        var arrayOfpositionsDesc=new Array();         
        for(var i=3; i<9; i++){
          Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true)
          //Valider que les positions ne sont pas bloquées   
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "IsBlocked", cmpEqual,false); //avant IsLegacy
          arrayOfpositionsDesc[i-3]=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SecurityDescription
        } 
        
        Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(arrayOfpositionsDesc[1]),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Validation des changements 
        for(var i=3; i <9; i++){
          //Valider que les positions sont bloquées   
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "IsBlocked", cmpEqual,true);
          aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "SecurityDescription", cmpEqual,arrayOfpositionsDesc[i-3]);         
        }
        
        //********************************************************************* Création d’un critère  ***************************************************************************
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLockedPosition().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
                
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpContains, criterion);
        
        //Valider que les comptes sont affichés         
       if(CheckPresenceOfAccount(account1)&& CheckPresenceOfAccount(account2)&&CheckPresenceOfAccount(account3)){
         Log.Checkpoint("Les comptes sont présents dans la grille")
       } 
       else{
         Log.Error("Un de comptes n’est pas présent dans la grille ")
       } 
               
        //Remettre les données à l’état initial  
        Get_ModulesBar_BtnPortfolio().Click();
        //Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).Keys("^a");
        //Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).ClickR();
        Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(arrayOfpositionsDesc[1]),10).ClickR();        
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();                     
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();  
             
        var arrayOfAccountsNo= new Array(account1,account2,account3)
        //Sélectionner 3 accounts
        SelectAccounts(arrayOfAccountsNo)   
         
        //Mailler les accounts sélectionnés ver le module client    
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();

        //Wait for grid 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).Keys("^a");
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).ClickR();        
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
       
        Close_Croesus_MenuBar();
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Delete_FilterCriterion(criterion,vServerOrders)//Supprimer le criterion de BD 
      Runner.Stop(true); 
    }
 }
 
 function CheckPresenceOfAccount(account)
 {
    var count=Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
    var found=false;
    for(var i=0; i<count; i++){
      if(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber==account){
        found=true;  
        break;  
      } 
    } 
    return found;
 } 

